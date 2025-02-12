# Get the images
data "openstack_images_image_v2" "debian" {
  provider    = openstack.ovh
  name        = "Debian 12"
  most_recent = true
}

# Instances
data "openstack_compute_flavor_v2" "instance_flavor" {
  provider = openstack.ovh
  name     = var.instance_flavor
}

# Create private network
resource "openstack_networking_network_v2" "private_net" {
  provider       = openstack.ovh
  name           = "${var.project_name}-network"
  admin_state_up = "true"
}

# Create private subnet
resource "openstack_networking_subnet_v2" "private_subnet" {
  provider    = openstack.ovh
  name        = "${var.project_name}-subnet"
  network_id  = openstack_networking_network_v2.private_net.id
  cidr        = var.private_network_cidr
  ip_version  = 4
  enable_dhcp = true
}

# Create additional volumes
resource "openstack_blockstorage_volume_v3" "volumes" {
  provider    = openstack.ovh
  count       = var.instance_count * length(var.additional_volumes)
  
  name        = "${var.instance_prefix}-${floor(count.index / length(var.additional_volumes)) + 1}-volume-${count.index % length(var.additional_volumes) + 1}"
  size        = var.additional_volumes[count.index % length(var.additional_volumes)]
  region      = var.region
  volume_type = var.volume_type
}

# Create keypair in OpenStack
resource "openstack_compute_keypair_v2" "keypair" {
  provider   = openstack.ovh
  name       = "${var.project_name}-${var.environment}-key"
  public_key = var.ssh_key_public
}

# Create the instances
resource "openstack_compute_instance_v2" "instance" {
  provider    = openstack.ovh
  count       = var.instance_count
  name        = "${var.instance_prefix}-${count.index + 1}-${var.environment}"
  image_id    = data.openstack_images_image_v2.debian.id
  flavor_id   = data.openstack_compute_flavor_v2.instance_flavor.id
  region      = var.region
  key_pair    = openstack_compute_keypair_v2.keypair.name

  network {
    name = "Ext-Net"
  }

  network {
    name = openstack_networking_network_v2.private_net.name
    fixed_ip_v4 = cidrhost(var.private_network_cidr, var.ip_start_index + count.index)
  }

  tags = [var.environment, var.project_name]

  user_data = file("${path.module}/scripts/setup_raid.sh")
}

# Attach volumes to instances
resource "openstack_compute_volume_attach_v2" "attachments" {
  provider = openstack.ovh
  count    = var.instance_count * length(var.additional_volumes)
  
  instance_id = openstack_compute_instance_v2.instance[floor(count.index / length(var.additional_volumes))].id
  volume_id   = openstack_blockstorage_volume_v3.volumes[count.index].id
}

# Export public IPs to file
resource "local_file" "public_ips" {
  filename = "${path.module}/public_ips.txt"
  content  = join("\n", [
    for instance in openstack_compute_instance_v2.instance : 
    "${instance.name} ${instance.access_ip_v4}"
  ])
}

# Export private IPs to file
resource "local_file" "private_ips" {
  filename = "${path.module}/private_ips.txt"
  content  = join("\n", [
    for idx, instance in openstack_compute_instance_v2.instance : 
    "${instance.name} ${cidrhost(var.private_network_cidr, var.ip_start_index + idx)}"
  ])
}
