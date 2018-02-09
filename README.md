# Installing a BOSH Instance for Managing Tools

## Requirements

* Bosh repo
  * The path is set in the [vars.yml](vars.yml) file to "~/workspace/bosh-deployment", you can change it by modifying that string
* [Vars File](vars.yml)
  * Be sure you update the values as is appropriate for your environment
* tools
  * yaml2json
  * jq

## Assumptions

* Cloud Config
  * Explain how to pull it from opsman
  * this actually isn't required here but we may add updating the cloud config to this repo
  * consider adding steps to upload stemcells and releases for deployments in air gapped environments

## Walkthrough

## TL;DR

## TODO

* Support other IaaS offerings, currently only written with VSphere in mind and with vbox as a practice run
  * AWS
  * GCP
  * Azure
* Distribute as a container
  * Bake tools and the bosh repo into it
