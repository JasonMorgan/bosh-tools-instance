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

* Navigate into this repo
  * `cd path-to-this-repo/bosh-tools-instance`
* Copy the vars.yml file into a file called vars.local.yml
  * `cat vars.yml > vars.local.yml`
* Update the information in the repo to match your actual environment
  * The fields in the vars file all have descriptions that should allow you to understand what information is required
* run the init script with the appropriate argument
  * create-env if you want a new director
  * delete-env if you want to destroy a director

```bash
chmod +x init.sh
./init.sh create-env
```

or

```bash
chmod +x init.sh
./init.sh delete-env
```

obviously you'll only need to do the chmod operation once.

### Connecting to the director

* Set some vars

```bash
export my_director_ip=$(yaml2json < ./vars.local.yml | jq -r '.internal_ip')
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=`bosh int ./creds.yml --path /admin_password`
```

* Test your connection:

`bosh environment -e $my_director_ip --ca-cert <(bosh int ./creds.yml --path /director_ssl/ca)`

* Alias the environment

`bosh alias-env bt -e $my_director_ip --ca-cert <(bosh int ./creds.yml --path /director_ssl/ca)`

* Optional: Make a simple alias for bosh

`alias bt='bosh -e bt'`

## TODO

* Support other IaaS offerings, currently only written with VSphere in mind and with vbox as a practice run
  * AWS
  * GCP
  * Azure
* Distribute as a container
  * Bake tools and the bosh repo into it
