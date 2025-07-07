# MicroK8s-Cluster
My Homelab
- [MicroK8s](https://microk8s.io/docs/getting-started)
- [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector)
```
docker build -t go-terry-hello .
docker save go-terry-hello > /cronjob/go-hello.docker.tar
microk8s ctr images import go-hello.docker.tar 

# Had to run again due to mismatching she
microk8s ctr images import go-hello.docker.tar 
k run td-hello --image=go-terry-hello --image-pull-policy='IfNotPresent'
```
