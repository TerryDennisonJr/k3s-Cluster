# Weather App

## `raspi4Node` Configuration

* This Raspberry Pi has the sensehat
* raspi4Node has `label` applied to target `pod` app to `Node`

```text
deployment_node: weather_app
```

### 1. Build image

```text
docker pull arm64v8/ubuntu
docker build -t <USER>/<NAME>:<TAG> -f <DOCKERFILE> .
```

* `infinitiq502004/raspiweather:1.0 -f k8s_weather/Dockerfile .` for full app
* `infinitiq502004/raspiweather_only:1.0 -f k8s_weather_only/Dockerfile2 .` for just weather app

### 2. Push image to dockerhub account

```text
docker push infinitiq502004/<NAME>:<TAG>
```

* `infinitiq502004/raspiweather:<TAG>` for full app
* `infinitiq502004/raspiweather_only:<TAG>` for just weather app

## Applying weather pods to `raspi4Node` `Node`

* Adding the `nodeSelector` to target pod to `raspi4Node` `Node`

```text
nodeSelector:
    deployment_node: weather_app
```