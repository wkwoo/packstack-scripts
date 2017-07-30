#!/bin/bash -e

NOVA_CONFIG=/etc/nova/nova.conf 

if [[ ! -e ${NOVA_CONFIG} ]]; then
  echo -e "\nNova config file does not exists. Is OpenStack installed?"
  exit 1
fi

# Check for KVM support in the OpenStack host. 
#  * result == 0: use qemu,
#  * result >= 1: can use kvm
# Note: The vmx/svm flag is not exposed to guest OS if a hypervisor does not
# support nested virtualization, for example VirtualBox.
# The support for nested virtualizatio may needs to be explicitly enabled on
# the hypervisor for a guest. For example, in VMware Workstation or Player: in
# Virtual Machine Settings > Hardware > Processors > Virtualization Engine, 
# the following needs to be enabled or set:
# 1. Select "Intel VT-x/EPT or AMD-V/RVI" for Preferred Mode
# 2. Check "Virtualize Intel VT-x/EPT or AMD-V/RVI"
# 3. Check "Virtualize CPU performance counters"
# See the following URL for details:
# https://www.server-world.info/en/note?os=CentOS_7&p=vmware_player&f=3
echo -e "\nChecking if the OpenStack host supports KVM..."
VMX_EXPOSED=$(grep -Ec '(vmx|svm)' /proc/cpuinfo)
if (( VMX_EXPOSED > 0 )); then
  echo "KVM is supported. Updating Nova configuration..."
  sudo sed -i 's/^\(virt_type\s*=\s*\).*$/\1kvm/' ${NOVA_CONFIG}
else
  echo "KVM not supported. QEMU will be used for Nova virtualisation."
  sudo sed -i 's/^\(virt_type\s*=\s*\).*$/\1qemu/' ${NOVA_CONFIG}
fi
grep ^virt_type ${NOVA_CONFIG}

echo -e "\nRestarting Nova Compute service..."
sudo systemctl restart openstack-nova-compute.service

