class profile::icingaweb {
  class { 'icingaweb2':
    manage_repo    => true,
    install_method => 'package',
  }
}