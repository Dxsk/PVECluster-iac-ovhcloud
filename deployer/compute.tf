# Get the images
data "openstack_images_image_v2" "debian" {
  provider    = openstack.ovh
  name        = "Debian 12"
  most_recent = true
}

# Instances flavor
data "openstack_compute_flavor_v2" "instance_flavor" {
  provider = openstack.ovh
  name     = var.instance_flavor
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