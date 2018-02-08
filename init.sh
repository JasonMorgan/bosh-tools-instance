#!/bin/sh

# Test Dependencies

# Test and echo command, build/destroy
## Insert a switch statement here
### Liking the idea of using a var to say create-env or destroy-env


# Test Arguments
## Check for default vars file

# Run the bosh env command

# Drop the bosh-lite ops files
# Need to switch on the cpi, maybe add it as a var at the end, if it's an array don't quote it because bash scripting is the worst.
bosh create-env ~/workspace/bosh-deployment/bosh.yml \
  --state ./state.json \
  -o ~/workspace/bosh-deployment/virtualbox/cpi.yml \
  -o ~/workspace/bosh-deployment/virtualbox/outbound-network.yml \
  -o ~/workspace/bosh-deployment/bosh-lite.yml \
  -o ~/workspace/bosh-deployment/bosh-lite-runc.yml \
  -o ~/workspace/bosh-deployment/jumpbox-user.yml \
  -o ~/workspace/bosh-deployment/uaa.yml \
  -o ~/workspace/bosh-deployment/credhub.yml \
  --vars-store ./creds.yml \
  --vars-file vars.yml