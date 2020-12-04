#!/bin/bash
# move storidge-config file
cat /secret/storidge-config > /storidge/storidge-config

# stop container from exiting and k8s restarting daemonset
while true; do sleep 1; done

