class profile::icingaweb {
  class { 'epel': } ->
  class { 'icingaweb2':
    manage_repo    => true,
    install_method => 'package',
  }
}