#!/bin/bash

# Clear wtmp
cat /dev/null > /var/log/wtmp

# Remove this script
rm -rf /tmp/script.sh

# Remove Packer-related files and directories
rm -rf /tmp/packer-puppet-masterless
