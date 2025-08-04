#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'
DD_PATH="~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml"
SECRETS_PW=$1
AGENT_PW=$2

echo "${GREEN}Please enter secret password for App mysql connection${NC}"
read SECRETS_PW
echo "Secret Password is: ${YELLOW}$SECRETS_PW\n${NC}"

echo "${GREEN}Please enter agent password for Datadog mysql connection${NC}"
read AGENT_PW
echo "Agent Password is: ${YELLOW}$AGENT_PW\n${NC}"

sed -i '' "s|\          password: \"”|          password: \"${AGENT_PW}\"|" ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml

sleep 5

kubectl create secret generic mysql-secret --type="kubernetes.io/basic-auth" --from-literal=password=$SECRETS_PW

sleep 5

echo "${GREEN}Deploying app via Helm...\n${NC}"
helm install weather-app helm/pi-weather-chart

sleep 5

WEATHER_APP_POD_NAME=$(kubectl get pods -l app=mysql-db -o jsonpath="{.items[0].metadata.name}")
WEATHER_APP_CONTAINER_NAME=$(kubectl get pods -l app=mysql-db -o jsonpath="{.items[0].spec.containers[0].name}")

echo "\n${GREEN}The weather app pod name is:${NC} ${YELLOW}$WEATHER_APP_POD_NAME${NC}"
echo "\n${GREEN}The weather app container name is:${NC} ${YELLOW}$WEATHER_APP_CONTAINER_NAME${NC}"

sleep 3

echo "\n${GREEN}Standing by for database to initialize...${NC}"
sleep 150

echo "\n${GREEN}Datadog setup for mysql connection of Agent...\n${NC}"

# kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="ALTER USER 'datadog'@'%' IDENTIFIED BY '$AGENT_PW';"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="CREATE USER 'datadog'@'%' IDENTIFIED BY '$AGENT_PW';"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="GRANT REPLICATION CLIENT ON *.* TO 'datadog'@'%';"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="ALTER USER 'datadog'@'%' WITH MAX_USER_CONNECTIONS 5;"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="GRANT PROCESS ON *.* TO 'datadog'@'%';"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="GRANT SELECT ON performance_schema.* TO 'datadog'@'%';"
kubectl exec -it $WEATHER_APP_POD_NAME  -- mysql -uroot -p$SECRETS_PW --execute="GRANT SELECT ON mysql.innodb_index_stats TO 'datadog'@'%';"

echo "Upgrading Datadog Agent with Mysql Integration Configuration\n"

helm upgrade datadog-agent -f ~/Desktop/k3s-homelab/k3s-Cluster/datadog_observability/datadog/datadog.yaml  datadog/datadog

echo "\n${GREEN}Components Deployed:${NC} ${YELLOW}\n1. App\n2. Mysql \n3. Datadog Agent for Mysql Intgration configured\n4. Agent helm upgrade${NC}"
echo "\nCheck dd"