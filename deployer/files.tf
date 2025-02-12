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