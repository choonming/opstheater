class profile::icinga::server {

  $icinga2_db_fqdn = hiera('opstheater::icinga::mysql_fqdn')

  class { '::mysql::server':
    override_options  => { 
      'mysqld' => {
        'bind-address' => '0.0.0.0',
      }
    },
  }

  mysql::db { 'icinga2_data':
    user      => 'icinga2',
    password  => 'password',
    host      => '10.20.%',
    grant     => ['ALL'],
    before    => Class['icinga2::server'],
  } 

  class { 'icinga2::server':
    server_db_type => 'mysql',
    db_host => $icinga2_db_fqdn,
    db_port => '3306',
    db_name => 'icinga2_data',
    db_user => 'icinga2',
    db_password => 'password',
  }->

  icinga2::object::idomysqlconnection { 'mysql_connection':
     target_dir => '/etc/icinga2/features-enabled',
     target_file_name => 'ido-mysql.conf',
     host             => $icinga2_db_fqdn,
     port             => '3306',
     user             => 'icinga2',
     password         => 'password',
     database         => 'icinga2_data',
  }

  Icinga2::Object::Host <<| |>> { }

}
