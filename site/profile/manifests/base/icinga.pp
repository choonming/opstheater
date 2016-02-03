class profile::base::icinga {

  Icinga2::Object::Host {
    display_name  => $::fqdn,
    check_command   => 'cluster-zone',
    target_dir      => "/etc/icinga2/objects/hosts",
    target_file_name=> "${::fqdn}.conf",
  }

  Icinga2::Object::Apply_service {
    assign_where => 'host.address && host.vars.remote == true && host.vars.remote_endpoint',
    command_endpoint => 'host.vars.remote_endpoint',
  }

  @@icinga2::object::host { $::fqdn:
    ipv4_address => $::ipaddress,
    vars => {
      os      => 'Linux',
      "disks" => {
        '"disks"'   => { },
        '"disk /"'  => { '"disk_partitions"' => '"/"' }
      },
      remote   => true,
      remote_endpoint => $::fqdn
    },
  }

  @@icinga2::object::apply_service { "check_user":
    check_command => 'users',
  }

}
