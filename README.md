# k3s-Cluster
* Devices: Raspberry Pi
* Master: (pi5 16GB)
* Worker: (p4 8GB)
* OS: Raspian Lite (64-bit)

# My K8's Homelab
* Orchestration: [k3s](https://docs.k3s.io/quick-start)

### Setup
* [Youtube Vid](https://www.youtube.com/watch?v=6PqxJhV-t1s)

1. Run [script](https://github.com/TerryDennisonJr/k3s-Cluster/blob/main/k8_sstup.sh)
```
sh <PARH_TO_SCRIPT>
```
2. Add `cgroup_enable=memory cgroup_memory=1` at end of line in `/boot/firmware/cmdline.txt` file 
```
 ...cgroup_enable=memory cgroup_memory=1
```
3. Reboot
```
sudo reboot
```
4. Install k3s (Master)
```
# MASTER
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
```

5. Install k3s (Worker)
* locate `Master_NODE_TOKEN` info on MASTER node at `/var/lib/rancher/k3s/server/node-token`
* locate `MASTER_NODE_IP_ADDR` info on MASTER node with `ip a`

```
# WORKER
curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_NODE_IP_ADDR>:6443 K3S_TOKEN=<Master_NODE_TOKEN> sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
```
6. Setup computer to communicate with raspiberryPi K8's cluster at `/etc/hosts` 

```
<MATER_NODE_IP_ADDR> <MASTER_NODE_NAME>
<WORKER_NODE_IP_ADDR> <WORKER_NODE_NAME>
```
7. Make a ` ~/.kube/config` file on computer and copy data from ` etc/rancher/k3s/k3s.yaml` in file
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: <VALUE>
    server: https://<MASTER_NODE_IP_ADDR>:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    client-certificate-data: <VALUE>

```
```

```
# Deploying example image from host with `microK8s`":
```
k run <NAME> --image=<VALUE> --image-pull-policy='IfNotPresent'
```
