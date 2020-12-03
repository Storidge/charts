#!/bin/bash
set -eux

# use storidge-config template file in /storidge
cd /storidge

# get cluster info
kubectl config view --flatten --minify
CLUSTERNAME=`kubectl config view --minify -o jsonpath='{.clusters[].name}'`
SERVER=`kubectl config view --minify -o jsonpath='{.clusters[].cluster.server}'`
CADATA=`kubectl config view --raw --minify --flatten -o jsonpath='{.clusters[].cluster.certificate-authority-data}'`

# set kubeconfig variables in /storidge/storidge-config
kubectl config --kubeconfig=storidge-config set-cluster $CLUSTERNAME --server=$SERVER 
kubectl config --kubeconfig=storidge-config set clusters.kubernetes.certificate-authority-data $CADATA
kubectl config --kubeconfig=storidge-config set-context storidge-context --cluster=$CLUSTERNAME --user=storidge

TOKEN=`kubectl -n kube-system get secret storidge-secret -o jsonpath='{.data.token}'| base64 --decode`
kubectl config --kubeconfig=storidge-config set-credentials storidge --token=$TOKEN

# save storidge-config as kube secret
kubectl create secret generic storidge-config --from-file=storidge-config

# log completion status
echo "storidge-config secret created"

# use TERM signal to exit daemonset
trap 'exit' TERM

# stop container from exiting and k8s restarting daemonset
while true; do sleep 1; done
