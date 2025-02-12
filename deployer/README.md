# Lab Proxmox VE on OVH Public Cloud

This OpenTofu project allows to automatically deploy a Proxmox VE (PVE) environment on OVH Public Cloud using a Debian 12 instance as base.

## Description

This project automates the creation of a Proxmox VE server for a lab/test environment. It:
- Deploy a Debian 12 instance on OVH Public Cloud
- Configure system prerequisites
- Installs and configures Proxmox VE
- Configure the network and basic security

### Instance Specifications
- Type: d2-2 (2 vCPUs, 4GB RAM)
- Debian 12 (Bookworm)
- Region: GRA11 (configurable)
- Network: Public access

## Prerequisites

- [OpenTofu](https://opentofu.org/) installed locally
- An OVH Public Cloud account
- OVH and OpenStack API credentials
- Has configured SSH access

## Configuration

1. Create your OVH API credentials on [https://api.ovh.com/createToken/](https://api.ovh.com/createToken/)
   Required API rights:
   `
   GET   /cloud/*
   POST   /cloud/*
   PUT   /cloud/*
   DELETE /cloud/*
   `

2. Retrieve your OpenStack credentials:
   - Go to Public Cloud > Users & Roles > Download OpenStack RC File

3. Prepare your configuration:
   `bash
   # Copy the sample file
   cp terraform.tfvars.example terraform.tfvars
   
   # Edit the file with your credentials
   vim terraform.tfvars
   `

## Deployment

`bash
# Initialization
init tofu

# Plan Verification
tofu plan

# Deployment
tofu apply

# To destroy infrastructure
tofu destroy
`

## Post-installation

Once the instance is deployed:

1. Log in via SSH:
   `bash
   ssh debian@<instance_ip>
   `

2. The Proxmox web interface will be accessible at:
   `
   https://<instance_ip>:8006
   `

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment (dev, prod, etc.) | string | - | yes |
| project_name | Project name | string | - | yes |
| region | OVH Region | string | "GRA11" | no |
| openstack_tenant_id | OpenStack project ID | string | - | yes |
| ... | ... | ... | ... | ... | ... |

## Outputs

| Name | Description |
|------|--------------|
| instance_ip | Proxmox instance public IP |

## Security

⚠️ Important points:
- Change default passwords
- Set up a suitable firewall
- Use VPNs for remote access in production
- This project is designed for a lab, additional configurations are required for production

## Known limitations

- Basic configuration of Proxmox (perfect for a lab)
- Single instance (no cluster)
- Public network only (consider a VPN for production)

## Contribution

Contributions are welcome! Please feel free to:
- Open issue for bugs
- Propose improvements
- Submit pull requests

## License

MIT

## Support

For any questions or issues:
1. Consult existing issues
2. Open a new issue if necessary 