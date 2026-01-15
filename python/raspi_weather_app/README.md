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

* `infinitiq502004/raspiweather:3.5 -f k8s_weather/Dockerfile .` for full app
* `infinitiq502004/raspiweather_only:3.5 -f k8s_weather_only/Dockerfile2 .` for just weather app

### 2. Push image to dockerhub account

```text
docker push infinitiq502004/<NAME>:<TAG>
```

* `infinitiq502004/pi-weather:<TAG>` for full app
* `infinitiq502004/pi-weather_only:<TAG>` for just weather app

## Setting weather pod to specific raspberrypi `Node`

* Adding the `nodeSelector` to target pod to `raspi4Node` `Node`

```bash
k label node <NODE> deployment_node=sensehatpi
```

Raspberry Pi with sensehat

```yaml
nodeSelector:
    deployment_node: sensehatpi
```

Raspberry Pi for database

```yaml
nodeSelector:
    deployment_node: sensehatpi
```

---

## Deploying App

* run `bash` script

```bash
sh app_deploy.sh
```

## Tearing Down App

* run teardown `bash` script

```bash
sh app_teardown.sh
```

## Notes

* Dev Container Image `infinitiq502004/pi-weather:3.1`

```sql
SELECT * FROM weather_db.weather_table;
```

```bash
for i in {1..9}; do python3 mnt/host-data/sensehat_mysql.py ;done
```
