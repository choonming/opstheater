# opscenter-control
Control repository for an entire opscenter deployment

## Puppet

Make sure to adjust your puppet master to have the `hiera_config` setting pointing at `/etc/puppetlabs/code/environments/production/hiera.yaml`

## List of needed vm's

OpsCenter is currently buitl up of a number of virtual machines. Here's a list of them and their prerequisites.

### zulip

zulip needs to currently run on ubuntu 14.04, installation instructions are here: https://www.zulip.org/server.html

### galera001-galera003
