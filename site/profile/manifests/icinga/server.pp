class profile::icinga::server {

  $icinga2_db_ipaddress = hiera('opstheater::icinga::mysql_ipaddress')

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

  class { 'icinga2::database':
  } -> 

  class { 'icinga2':
    db_type => 'mysql',
    db_host => $icinga2_db_ipaddress,
    db_port => '3306',
    db_name => 'icinga2_data',
    db_user => 'icinga2',
    db_pass => 'password',
  }

  Icinga2::Object::Host <<| |>> { }

}