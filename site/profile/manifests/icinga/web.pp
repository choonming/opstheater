class profile::icinga::web {

  if ! defined (Class['epel']) {
    class { 'epel': }
  }
  
  class { 'apache': 
    default_vhost => false,
  } 
  
  class { 'apache::mod::php': } 

  class { 'icingaweb2':
    manage_repo    => true,
    install_method => 'package',
    manage_apache_vhost => true,
    apache_vhost_name => 'icinga.olindata.com',
  }
}
