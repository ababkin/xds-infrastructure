`kubectl get nodes`

`kubectl create -f ./xds-downloader-pod.json`

`kubectl get pods`

`kubectl delete pods xds-downloader`

inspect logs
`kubectl logs xds-downloader`

history of restarts
`kubectl describe pods xds-downloader`

all cluster events
`kubectl get events`

view replication controllers
`kubectl get rc`

see pods' IPs
`kubectl get pods -l app=nginx -o json | grep podIP`
