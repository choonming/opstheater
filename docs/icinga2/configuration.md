# Icinga 2 Setup

http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/getting-started#setting-up-icinga2

Deployed via puppet profile. Run puppet twice

# Icinga Web 2 Setup

https://github.com/Icinga/icingaweb2/blob/master/doc/installation.md

Deployed via puppet profile. Run puppet twice

# Icinga Monitoring

Checks are deployed to the agents via exported resources. This means you'll need to run puppet on the icinga2 server each time you add a node or wait for the next puppet run.

`
  @@icinga2::object::host { $::fqdn:
    display_name => $::fqdn,
    ipv4_address => $::ipaddress_eth0,
    groups => ['linux-servers'],
    vars => {
      os              => 'Linux',
      "disks[\"disk\"]" => { },
      "disks[\"disk /\"]" => { "disk_partitions" => '"/"' },
    },
    target_dir => '/etc/icinga2/objects/hosts',
    target_file_name => "${fqdn}.conf"
  }`
  
The code above will add host monitoring. The vars hash will fulfil certain icinga built-in rules that will auto group the servers with generic-checks. The vars.disks will tell Icinga to make the keyword "disks" to automatically apply the check_disks service to this host.