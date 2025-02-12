terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 0.34.0"
    }
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = var.ovh_application_key
  application_secret = var.ovh_application_secret
  consumer_key       = var.ovh_consumer_key
}

provider "openstack" {
  auth_url    = "https://auth.cloud.ovh.net/v3"
  domain_name = "default"
  alias       = "ovh"
  tenant_id   = var.openstack_tenant_id
  user_name   = var.openstack_username
  password    = var.openstack_password
  region      = var.region
} 