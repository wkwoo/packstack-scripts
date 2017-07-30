#!/bin/bash -e

echo -e "\nInstalling OpenStack using Packstack.\nGo enjoy a cup of coffee as this will take quite a while...\n"
sudo packstack --answer-file=/root/packstack-answers.txt

echo -e "\nOpenStack installed successfully. Keystone files for admin user and demo user has been created."
sudo ls -l /root/keystonerc_*

echo -e "\nContent of /root/keystonerc_admin"
sudo cat /root/keystonerc_admin

echo -e "\nContent of /root/keystonerc_demo"
sudo cat /root/keystonerc_demo

