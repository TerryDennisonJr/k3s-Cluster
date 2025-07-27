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
sudo usermod -aG docker $USER && newgrp docker


#helm
echo "Helm Install"
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

echo -e "Set alias"
echo "alias k='kubectl'"

echo -e "Start new terminal session to run remaining commands in README:\n"