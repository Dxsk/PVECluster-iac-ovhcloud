variable "environment" {
  description = "Environment (dev, prod, etc.)"
  type        = string
}

variable "project_name" {
  description = "PVE Cluster Lab"
  type        = string
}

variable "ovh_application_key" {
  description = "Authentication key"
  type        = string
  sensitive   = true
}

variable "ovh_application_secret" {
  description = "Application secret"
  type        = string
  sensitive   = true
}

variable "ovh_consumer_key" {
  description = "Consumer key"
  type        = string
  sensitive   = true
}

variable "openstack_tenant_id" {
  description = "OpenStack project ID"
  type        = string
}

variable "openstack_username" {
  description = "OpenStack username"
  type        = string
}

variable "openstack_password" {
  description = "OpenStack password"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "OVH region (GRA11, SBG5, etc.)"
  type        = string
  default     = "GRA11"
}

variable "instance_count" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}

variable "instance_prefix" {
  description = "Prefix for instance names"
  type        = string
  default     = "pve"
}

variable "additional_volumes" {
  description = "List of additional volume sizes in GB"
  type        = list(number)
  default     = [1000, 1000]  # 2 disks of 1TB each for RAID1
}

variable "volume_type" {
  description = "Type of volume (classic or high-speed)"
  type        = string
  default     = "classic"
}

variable "private_network_cidr" {
  description = "CIDR for private network"
  type        = string
  default     = "192.168.0.0/24"
}

variable "ssh_key_public" {
  description = "Content of the SSH public key"
  type        = string
  sensitive   = true
}

variable "instance_flavor" {
  description = "Instance type/flavor (d2-2, d2-4, etc.)"
  type        = string
  default     = "d2-4"
} 