# Create additional volumes
resource "openstack_blockstorage_volume_v3" "volumes" {
  provider    = openstack.ovh
  count       = var.instance_count * length(var.additional_volumes)
  
  name        = "${var.instance_prefix}-${floor(count.index / length(var.additional_volumes)) + 1}-volume-${count.index % length(var.additional_volumes) + 1}"
  size        = var.additional_volumes[count.index % length(var.additional_volumes)]
  region      = var.region
  volume_type = var.volume_type
}

# Attach volumes to instances
resource "openstack_compute_volume_attach_v2" "attachments" {
  provider = openstack.ovh
  count    = var.instance_count * length(var.additional_volumes)
  
  instance_id = openstack_compute_instance_v2.instance[floor(count.index / length(var.additional_volumes))].id
  volume_id   = openstack_blockstorage_volume_v3.volumes[count.index].id
} 