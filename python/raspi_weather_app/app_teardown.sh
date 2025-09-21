#!/bin/bash

helm delete weather-app
#Agent helm file
rm -r ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml
cp -r ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/template/template_datadog.yaml ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml
#Sensehat app file
# rm -r ~/Desktop/k3s-homelab/k3s-Cluster/python/raspi_weather_app/k8s_weather/sensehat_mysql.py
# cp -r ~/Desktop/k3s-homelab/k3s-Cluster/python/template_files/sensehat_mysql.py ~/Desktop/k3s-homelab/k3s-Cluster/python/raspi_weather_app/k8s_weather/

helm upgrade datadog -f ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml  datadog/datadog