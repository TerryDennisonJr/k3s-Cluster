# MicroK8s-Cluster
My Homelab
- [MicroK8s](https://microk8s.io/docs/getting-started)
- [Assigning Pods to Nodes](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector)
```
docker build -t <NAME> .
docker save <NAME> > <NAME>.docker.tar
microk8s ctr images import <NAME>.docker.tar 

# Had to run again due to mismatching sha on first run:
microk8s ctr images import <NAME>.docker.tar 
```

# Deploying example image from host with `microK8s`":
```
k run <NAME> --image=<VALUE> --image-pull-policy='IfNotPresent'
```
