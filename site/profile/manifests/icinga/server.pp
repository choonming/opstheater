class profile::icinga::server {

  $icinga2_db_ipaddress = hiera('opstheater::icinga::mysql_ipaddress')
  $icinga2_web_fqdn = hiera('opstheater::icingaweb::fqdn')

  class { '::mysql::server':
    remove_default_accounts => true,
    override_options  => { 
      'mysqld' => {
        'bind-address'      => '0.0.0.0',
        'skip-name-resolve' => true,
      }
    },
  }

  mysql::db { 'icinga2_data':
    user      => 'icinga2',
    password  => 'password',
    host      => '10.20.%',
    grant     => ['ALL'],
    before    => Class['icinga2'],
  } ->

  class { 'icinga2':
    db_type         => 'mysql',
    db_host         => $icinga2_db_ipaddress,
    db_port         => '3306',
    db_name         => 'icinga2_data',
    db_user         => 'icinga2',
    db_pass         => 'password',
    manage_database => true,
  }

  include ::icinga2::feature::command

  icinga2::object::zone { 'global-templates':
    global  => true,
  }

  icinga2::object::zone { 'master':
    endpoints => {
      $icinga2_web_fqdn => {
        host  => $icinga2_web_fqdn,
      },
    },
  }

  class { '::icinga2::feature::api':
    manage_zone => false,
  }

  # icinga2::pki::puppet class needs to be declared
  # after the icinga2::feature::api class in order
  # to avoid resource duplication

  contain ::icinga2::pki::puppet

  Icinga2::Object::Host <<| |>>
  Icinga2::Object::Service <<| |>>
  Icinga2::Object::Apply_service <<| |>>
  Icinga2::Object::Zone <<| |>>

}
