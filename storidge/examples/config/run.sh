#!/bin/bash
#set -euxo pipefail
set -eux

# move storidge-config file
cat /secret/storidge-config > /storidge/storidge-config
# identify config-move pod on local node and delete
kubectl get po

# log completion status
echo "done"

# use TERM signal to exit daemonset
trap 'exit' TERM

# stop container from exiting and k8s restarting daemonset
while true; do sleep 1; done
