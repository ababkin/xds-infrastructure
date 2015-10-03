
ssh to coreos instance: 
`ssh -i "xdataset.pem" core@52.6.153.240`

`fleetctl list-machines`

`ssh -A -L 8500:<private IP of a consul server node>:8500 core@<public IP of the same node>`
then open 'http://localhost:8500' in browser


system units are in `/etc/systemd/system`, custom unit files can be anywhere


put unit config into xds-downloader@.service

`fleetctl submit xds-downloader@.service`
`fleetctl start xds-downloader@1`

if updating the unit file, need to destroy all instances of service, then resubmit and restart
`fleetctl destroy xds-downloader@`
then destroy all instances
`fleetctl destroy xds-downloader@1`
...



check status of the unit, see the logs: 
`fleetctl status xds-downloader@1`

for some reason if unit is running on a different node than one logged in to it errors and asks for ssh-agent
^ if you ssh-add the identity and ssh with -A, it works

## Troubleshooting

### Check logs
`systemctl status -l etcd`
`systemctl status -l fleet`

`journalctl -b -u etcd`

this one looks to be useful
`fleetctl journal xds-downloader@3`



### List running units:
`fleetctl list-unit-files`
or
`fleetctl list-units`


### inspect docker containers logs
`docker logs <container id>`




## etcd2 and kubernetes

### troubleshooting

`systemctl restart etcd2`



### questions
- why when running `fleetctl start xds-downloader@` it hangs? then running `fleetctl start xds-downloader@1` works fine?
- whats the best way to pass sensitive data to executable running inside the container?








