class opstheater::profile::icinga::checks {

  Icinga2::Object::Apply_service {
    assign_where => 'host.address && host.vars.remote == true && host.vars.remote_endpoint',
    command_endpoint => 'host.vars.remote_endpoint',
  }

  icinga2::object::apply_service { 'user':
    check_command => 'users',
  }

  icinga2::object::apply_service { 'ssh':
    check_command => 'ssh',
  }

  icinga2::object::apply_service { 'load':
    check_command => 'load',
  }

  icinga2::object::apply_service { 'process':
    check_command => 'procs',
  }

  icinga2::object::apply_service { 'swap':
    check_command => 'swap',
  }

  icinga2::object::apply_service { 'disk':
    check_command => 'disk',
    display_name  => undef,
    apply         => 'for (disk => config in host.vars.disk)',
    vars          => 'config',
  }

}
