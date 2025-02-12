#!/bin/bash

# Check if the user is root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# Install the necessary tools
apt update
apt install -y mdadm

# Wait for the volumes to be available
while [ ! -e /dev/vdb ] || [ ! -e /dev/vdc ]; do
  sleep 1
done

# Create the RAID 1
mdadm --create /dev/md0 --level=1 --raid-devices=2 /dev/vdb /dev/vdc

# Create the filesystem
mkfs.ext4 /dev/md0

# Create the mount point for the datastore_one_raid
mkdir -p /var/lib/pve/datastore_one_raid

# Configure automatic mounting in fstab
echo "/dev/md0 /var/lib/pve/datastore_one_raid ext4 defaults 0 0" >> /etc/fstab
mount /var/lib/pve/datastore_one_raid

# Save the RAID configuration
mdadm --detail --scan >> /etc/mdadm/mdadm.conf
update-initramfs -u

# Configure permissions for Proxmox
chown root:root /var/lib/pve/datastore_one_raid
chmod 755 /var/lib/pve/datastore_one_raid