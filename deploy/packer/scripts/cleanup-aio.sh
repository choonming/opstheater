#!/bin/bash

# AIO puppet-agent is currently used to provision nocm and puppet boxes.
# This script cleans up directories that may be left around
# as part of that process.

# Uninstall the AIO
if [[ ${PC_REPO} == *".rpm"* ]] ; then
  rpm -e puppet-agent
  rpm -e puppetlabs-release-pc1
elif [[ ${PC_REPO} == *".deb"* ]] ; then
  dpkg -P puppet-agent
else
  echo "Unsupported AIO package format" >&2
  exit 1
fi
# Remove any Puppet-related files and directories
rm -rf /etc/puppetlabs
rm -rf /opt/puppetlabs
