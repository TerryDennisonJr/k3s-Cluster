# Helm Install of Agent

## Create Secret

```bash

kubectl create secret generic datadog-secret --from-literal api-key=<VALUE> --from-literal app-key=<VALUE>
```

## Install Agent

- Using `datadog-agent.yml` file

```bash
helm install datadog-agent -f datadog-agent.yml datadog/datadog
```
