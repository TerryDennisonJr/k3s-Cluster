#!/bin/bash

#Docker
sudo echo "Docker Install"
sudo apt install docker.io -y


#helm
echo "Helm Install"
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh

echo -e "Close terminal ssh session and re-connect to run commands:\n"

echo "sudo usermod -aG docker $USER && newgrp docker"
echo "alias k='kubectl'"

echo "Rebooting as k3s service needed memory addition to properly run."
sudo reboot
