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

`kubectl get services`




troubleshooting:

list running pods:
`kubectl get pods`

then use the pod ids to inspect logs:
`kubectl logs --previous xds-site-rc-8rv5d`

