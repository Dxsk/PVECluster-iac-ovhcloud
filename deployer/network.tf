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