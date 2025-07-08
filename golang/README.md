# Create `cronjob` and run test `job:`

```
k create cronjob td-cronjob --image=go-terry-hello --schedule='0/5 * * * ?'
k create job cronjob-$(date '+%Y%m%d%H%M') --from=cronjob/td-cronjob
```
