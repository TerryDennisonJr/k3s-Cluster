#!/bin/bash

kubectl delete secret mysql-secret
helm delete weather-app helm/pi-weather-chart
rm -r ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml
cp -r ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/template/template_datadog.yaml ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml
helm upgrade datadog-agent -f ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml  datadog/datadog