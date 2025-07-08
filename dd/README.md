# Helm Install of Agent

### Create Secret
```
k create secret generic datadog-secret --from-literal api-key=<VALUE> --from-literal app-key=<VALUE>
```
### Install Agent
- Using `datadog-agent.yml` file

```
helm upgrade datadog-agent -f datadog-agent.yml datadog/datadog
```
