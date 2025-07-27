#!/bin/bash

#Checking ip_address use command "ip a or ifconfig"
#Masterpi5: 192.168.0.29
#node1:
#node2:

echo -e "Useful Info:\n"
echo $USER
ip a
echo -e "\n"
sleep 30

#Docker
sudo echo "Docker Install"
sudo apt install docker.io -y


#helm
echo "Helm Install"
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

echo -e "Close terminal ssh session and re-connect to run commands:\n"

#Rancher
echo -e "k3s install...\n"
echo -e "curl -sfL https://get.k3s.io | sh -\n"
echo -e "sudo chmod 644 /etc/rancher/k3s/k3s.yaml\n"


# sudo sed -i '1s_$_ cgroup_enable=memory cgroup_memory=1_' /boot/firmware/cmdline.txt 
# echo -e "Add cgroup_enable=memory cgroup_memory=1 to /boot/firmware/cmdline.txt "


echo "sudo nano /boot/firmware/cmdline.txt"
echo -e "ADD to file 'cgroup_enable=memory cgroup_memory=1'\n"
echo "sudo usermod -aG docker $USER && newgrp docker"

echo "alias k='kubectl'"

echo "Rebooting as k3s service needed memory addition to properly run."
sudo reboot