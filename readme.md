# Proxmox VE Lab Environment on OVH Public Cloud

This project allows you to automatically deploy and configure a Proxmox VE environment on OVH Public Cloud using Infrastructure as Code (IaC) principles.

## Project Structure

The project is organized into two main directories:

### /deployer

Contains the OpenTofu (Terraform) code to provision the infrastructure:

- Creates Debian 12 instances on OVH Public Cloud
- Sets up networking and security groups
- Manages additional block storage volumes
- Outputs instance information for Ansible

Key files:
- |main.tf| - Main infrastructure definition
- |variables.tf| - Variable declarations
- |outputs.tf| - Output definitions
- |providers.tf| - Provider configurations

### /provisioner 

Contains the Ansible playbooks to configure the instances:

- Installs and configures Proxmox VE
- Sets up networking and storage
- Configures security settings
- Manages post-installation tasks

Key files:
- |site.yml| - Main playbook
- |inventory.yml| - Dynamic inventory (generated)
- |group_vars/| - Group variables
- |roles/| - Ansible roles for different components

## Usage Flow

1. Use the deployer to create infrastructure:
   ```bash
   cd deployer
   tofu init
   tofu plan
   tofu apply
   ```

2. Use the provisioner to configure instances:
   ```bash
   cd ../provisioner
   ansible-playbook -i inventory.yml site.yml
   ```

## Documentation

- See |deployer/README.md| for detailed infrastructure deployment instructions
- See |provisioner/README.md| for configuration management details
- Check individual role documentation in |provisioner/roles/*/README.md|


