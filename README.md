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
1. 4 GiB memory (preferably 6 GiB or more)
2. 20 GiB disk
3. Minimal installation
4. Firewall service disabled
5. Network Manager service disabled (replaced by the network service)

Optionally, the Linux guest is configured with
1. A host-only-network with a static IP (useful for SSH access from host)
2. A hostname
3. Nested virtualisation enabled on the Linux guest from the hypervisor host. 
  * Refer to the 04-configure-nova.sh script for details.
  * https://www.server-world.info/en/note?os=CentOS_7&p=vmware_player&f=3

Instructions
--
1. Copy all scripts to the root user's home directory.
2. Edit the 02-prepare.sh script to update the network interface on the host 
to be used for Nova network public interface and Neutron OVS bridge interface. 
To be specific, look for the following two lines in the script:
* sudo sed -i 's/^\(CONFIG_NOVA_NETWORK_PUBIF\s*=\s*\).*$/\1ens34/' ${ANSWER_FILE}
* sudo sed -i 's/^\(CONFIG_NEUTRON_OVS_BRIDGE_IFACES\s*=\s*\).*$/\1br-ex:ens34/' ${ANSWER_FILE}
3. Execute each script one-by-one.
