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
      "disk" => {
        '" "'   => { },
        '" /"'  => { '"disk_partitions"' => '"/"' }
      },
      os      => 'Linux',
      remote   => true,
      remote_endpoint => $::fqdn
    },
  }

  @@icinga2::object::apply_service { "user":
    check_command => 'users',
  }

  @@icinga2::object::apply_service { "ssh":
    check_command => 'ssh',
  }

  @@icinga2::object::apply_service { "load":
    check_command => 'load',
  }

  @@icinga2::object::apply_service { "process":
    check_command => 'procs',
  }

  @@icinga2::object::apply_service { "swap":
    check_command => 'swap',
  }

  @@icinga2::object::apply_service { "disk":
    check_command => 'disk',
    display_name  => undef,
    apply => 'for (disk => config in host.vars.disk)',
    vars => 'config',
  }

}
