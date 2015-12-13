class profile::icinga::web {

  if ! defined (Class['epel']) {
    class { 'epel': }
  }
  
  class { 'apache': 
  } 
  
  class { 'apache::mod::php': } 

  class { 'icingaweb2':
    manage_repo    => true,
    install_method => 'package',
    manage_apache_vhost => true,
    apache_vhost_name => 'icinga.olindata.com',
    ido_db  => 'pgsql',
    ido_db_host => 'icinga2',
    ido_db_name => 'icinga2_data',
    ido_db_user => 'icinga2',
    ido_db_pass => 'password',
    ido_db_port => '5432',
    web_db      => 'pgsql',
    web_db_name => 'icinga2_web',
    web_db_host => 'icinga2',
    web_db_user => 'icingaweb',
    web_db_pass => 'password',
    web_db_port => '5432',
  }

}
