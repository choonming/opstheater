class profile::base::icinga {

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
  }

}
