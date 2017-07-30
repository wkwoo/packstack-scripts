#!/bin/bash -e
ANSWER_FILE=/root/packstack-answers.txt

echo -e "\nInstalling Packstack..."
sudo yum install openstack-packstack -y

echo -e "\nGenerating Packstack answer file ${ANSWER_FILE}..."
sudo packstack --gen-answer-file=${ANSWER_FILE}

echo -e "\nMaking backup of answer file..."
sudo cp -v ${ANSWER_FILE} ${ANSWER_FILE}.bak

echo -e "\nCustomising answer file..."
sudo sed -i 's/^\(CONFIG_NTP_SERVERS\s*=\s*\).*$/\10.centos.pool.ntp.org/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_DEFAULT_PASSWORD\s*=\s*\).*$/\1guiadmin/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_KEYSTONE_ADMIN_PW\s*=\s*\).*$/\1guiadmin/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_KEYSTONE_DEMO_PW\s*=\s*\).*$/\1guiadmin/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_CINDER_VOLUMES_SIZE\s*=\s*\).*$/\14G/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_NOVA_COMPUTE_PRIVIF\s*=\s*\).*$/\1lo/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_NOVA_NETWORK_PRIVIF\s*=\s*\).*$/\1lo/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_NEUTRON_OVS_BRIDGE_MAPPINGS\s*=\s*\).*$/\1extnet1:br-ex/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_USE_EPEL\s*=\s*\).*$/\1y/' ${ANSWER_FILE}

# NOTE: ens34 is NAT interface for Linux guest in VMware. Replace ens34 
# according to the hypervisor that you are using. For example, default NAT 
# interface name for a Linux guest in
# 1. VirtualBox - enp0s3
# 2. KVM - eth0 
# 3. VMware - ens34
sudo sed -i 's/^\(CONFIG_NOVA_NETWORK_PUBIF\s*=\s*\).*$/\1ens34/' ${ANSWER_FILE}
sudo sed -i 's/^\(CONFIG_NEUTRON_OVS_BRIDGE_IFACES\s*=\s*\).*$/\1br-ex:ens34/' ${ANSWER_FILE}

# Print value for parameters that we changed
echo -e "\nThe following parameters' value has been configured. Refer to the answer file ${ANSWER_FILE} for complete configurations."
grep ^CONFIG_NTP_SERVERS ${ANSWER_FILE}
grep ^CONFIG_DEFAULT_PASSWORD ${ANSWER_FILE}
grep ^CONFIG_KEYSTONE_ADMIN_PW ${ANSWER_FILE}
grep ^CONFIG_KEYSTONE_DEMO_PW ${ANSWER_FILE}
grep ^CONFIG_CINDER_VOLUMES_SIZE ${ANSWER_FILE}
grep ^CONFIG_NOVA_COMPUTE_PRIVIF ${ANSWER_FILE}
grep ^CONFIG_NOVA_NETWORK_PRIVIF ${ANSWER_FILE}
grep ^CONFIG_NEUTRON_OVS_BRIDGE_MAPPINGS ${ANSWER_FILE}
grep ^CONFIG_USE_EPEL ${ANSWER_FILE}
grep ^CONFIG_NOVA_NETWORK_PUBIF ${ANSWER_FILE}
grep ^CONFIG_NEUTRON_OVS_BRIDGE_IFACES ${ANSWER_FILE}

