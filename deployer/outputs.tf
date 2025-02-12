output "instance_ips" {
  description = "Public and Private IPs of all Proxmox instances"
  value       = {
    for idx, instance in openstack_compute_instance_v2.instance : 
    "${var.instance_prefix}-${idx + 1}" => {
      public_ip  = instance.access_ip_v4
      private_ip = instance.network[1].fixed_ip_v4
    }
  }
}

output "instance_volumes" {
  description = "Volumes attached to each instance"
  value = {
    for idx in range(var.instance_count) : 
    "${var.instance_prefix}-${idx + 1}" => [
      for vidx in range(length(var.additional_volumes)) :
      {
        volume_name = openstack_blockstorage_volume_v3.volumes[idx * length(var.additional_volumes) + vidx].name
        size_gb     = openstack_blockstorage_volume_v3.volumes[idx * length(var.additional_volumes) + vidx].size
        device      = "/dev/vd${substr("bcdefghijklmnopqrstuvwxyz", vidx, 1)}"
      }
    ]
  }
}

output "private_network" {
  description = "Private network details"
  value = {
    network_name = openstack_networking_network_v2.private_net.name
    subnet_cidr  = openstack_networking_subnet_v2.private_subnet.cidr
  }
} 