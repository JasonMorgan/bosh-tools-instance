#!/bin/sh

# Test Dependencies

# Test and echo command, build/destroy

case "$1" in
  create-env)
    action="create-env"
    echo "create-env set, creating a new bosh director"
    ;;
  delete-env)
    echo "delete-env set, deleting the bosh director"
    action="delete-env"
    ;;
  *)
    echo "No argument found for action, please call this script with either create-env or destroy-env"
    echo "exiting without taking any action"
    exit 1
esac


# [[ -z "$some_cool_var" ]] && echo "no some_cool_var" && exit 1

target_type=$(yaml2json < ./vars.yml | jq -r '.iaas|= ascii_downcase | .iaas')
bosh_repo=$(yaml2json < ./vars.yml | jq -r '.bosh_repo_path')

# Some cpi vars
# GCP_OPS=""
# AWS_OPS=""
# AZURE_OPS=""
VSPHERE_OPS="-o bosh-deployment/vsphere/cpi.yml"
VBOX_OPS="-o ~/workspace/bosh-deployment/virtualbox/cpi.yml -o ~/workspace/bosh-deployment/virtualbox/outbound-network.yml -o ~/workspace/bosh-deployment/bosh-lite.yml -o ~/workspace/bosh-deployment/bosh-lite-runc.yml"

if [ "$target_type" = "vsphere" ]; then
  ops=$VSPHERE_OPS
fi
if [ "$target_type" = "vbox" ]; then
  ops=$VBOX_OPS
fi 





# Use the ops in here
bosh "$action" "$bosh_repo/bosh.yml" \
  --state ./state.json \
  $ops \
  -o ~/workspace/bosh-deployment/misc/dns.yml \
  -o ~/workspace/bosh-deployment/jumpbox-user.yml \
  -o ~/workspace/bosh-deployment/uaa.yml \
  -o ~/workspace/bosh-deployment/credhub.yml \
  --vars-store ./creds.yml \
  --vars-file vars.yml