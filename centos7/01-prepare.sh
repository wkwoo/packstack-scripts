#!/bin/bash -e

# Install OpenStack Liberty release (using by COA exam)
echo -e "\nSetting up OpenStack Liberty repository..."
sudo yum install centos-release-openstack-liberty -y

# epel repository is needed
echo -e "\nSetting up epel repository..."
sudo yum install epel-release -y

echo -e "\nInstalling additional tools..."
sudo yum install bash-completion vim -y

echo -e "\nUpdating system..."
sudo yum upgrade -y

echo -e "\nPreparations completed. Reboot now? (y/n) "
read REBOOT
if [[ ${REBOOT} =~ y ]]; then
  echo "Rebooting now..."
  sudo reboot
else
  echo "Please reboot the machine before executing the next script."
fi
