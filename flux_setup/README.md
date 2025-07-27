# Flux Setup

```bash
flux bootstrap github \
  --GITHUB_TOKEN \
  --owner=TerryDennisonJr \
  --repository=k3s-Cluster \
  --branch=main \
  --path=clusters/k3s-cluster \
  --personal
```  

## 1. Create a GitRepository manifest pointing to podinfo repository’s master branch

```bash
flux create source git podinfo \
  --url=https://github.com/TerryDennisonJr/k3s-Cluster \
  --branch=master \
  --interval=1m \
  --export > ./clusters/k3s-cluster/podinfo-source.yaml
```
