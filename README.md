# packstack-scripts
Scripts to ease OpenStack installation using Packstack. 

These scripts are created while following Andrew Mallett's online course on
OpenStack in Pluralsight.
https://app.pluralsight.com/paths/certificate/certified-openstack-administrator-coa

* Supports only CentOS-7 installation for now
* Supports only OpenStack Liberty release
* Assumed that OpenStack will be installed into a virtualised environment

Requirements
--
A CentOS-7 Linux guest that is configured with
# 4 GiB memory (preferably 6 GiB or more)
# 20 GiB disk
# Minimal installation
# Firewall service disabled
# Network Manager service disabled (replaced by the network service)

Optionally, the Linux guest is configured with
# A host-only-network with a static IP (useful for SSH access from host)
# A hostname
# Nested virtualisation enabled on the Linux guest from the hypervisor host. 
## Refer to the 04-configure-nova.sh script for details.
## https://www.server-world.info/en/note?os=CentOS_7&p=vmware_player&f=3

Instructions
--
# Copy all scripts to the root user's home directory.
# Update the network interface on the host to be used for Nova network public 
interface and Neutron OVS bridge interface. 
# Execute each script one-by-one.
