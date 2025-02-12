# Create block storage volume
resource "openstack_blockstorage_volume_v3" "block_storage" {
  provider    = openstack.ovh
  name        = "${var.project_name}-block-storage-${var.environment}"
  description = "Block storage for ${var.project_name}"
  size        = var.block_storage_size
  volume_type = "classic-BETA"
  region      = var.region
}

# Create volume snapshot
resource "openstack_blockstorage_volume_v3" "snapshot_volume" {
  provider    = openstack.ovh
  name        = "${var.project_name}-snapshot-${var.environment}"
  description = "Snapshot volume for ${var.project_name}"
  size        = var.snapshot_volume_size
  volume_type = "classic"
  region      = var.region
} 