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

target_type=$(yaml2json < ./vars.local.yml | jq -r '.iaas|= ascii_downcase | .iaas')
bosh_repo=$(yaml2json < ./vars.local.yml | jq -r '.bosh_repo_path')

# Some cpi vars
# GCP_OPS=""
# AWS_OPS=""
# AZURE_OPS=""
VSPHERE_OPS="-o $bosh_repo/vsphere/cpi.yml"
VBOX_OPS="-o $bosh_repo/virtualbox/cpi.yml -o $bosh_repo/virtualbox/outbound-network.yml -o $bosh_repo/bosh-lite.yml -o $bosh_repo/bosh-lite-runc.yml"

case "$target_type" in
  vsphere)
    ops=$VSPHERE_OPS
    ;;
  vbox)
    ops=$VBOX_OPS
    ;;
  *)
    echo "target type: $target_type, is not supported."
    echo "exiting without taking any action"
    exit 1
esac

# Use the ops in here
bosh "$action" "$bosh_repo/bosh.yml" \
  --state ./state.json \
  $ops \
  -o $bosh_repo/misc/dns.yml \
  -o $bosh_repo/jumpbox-user.yml \
  -o $bosh_repo/uaa.yml \
  -o $bosh_repo/credhub.yml \
  --vars-store ./creds.yml \
  --vars-file vars.local.yml