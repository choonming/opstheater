class profile::icinga::server {

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

  mysql::db { 'icinga2_data_localhost':
    dbname    => 'icinga2_data',
    user      => 'icinga2',
    password  => 'password',
    host      => 'localhost',
    grant     => ['ALL'],
    before    => Class['icinga2::server'],
  } 

  mysql::db { 'icinga2_web':
    user      => 'icinga2_web',
    password  => 'password',
    host      => '10.20.%',
    grant     => ['ALL'],
    before    => Class['icinga2::server'],
  } 

  mysql::db { 'icinga2_web_localhost':
    dbname    => 'icinga2_web',
    user      => 'icinga2_web',
    password  => 'password',
    host      => 'localhost',
    grant     => ['ALL'],
    before    => Class['icinga2::server'],
  } 

  class { 'icinga2::server':
    server_db_type => 'mysql',
    db_host => 'localhost',
    db_port => '3306',
    db_name => 'icinga2_data',
    db_user => 'icinga2',
    db_password => 'password',
  }->

  icinga2::object::idomysqlconnection { 'mysql_connection':
     target_dir => '/etc/icinga2/features-enabled',
     target_file_name => 'ido-mysql.conf',
     host             => '127.0.0.1',
     port             => '3306',
     user             => 'icinga2',
     password         => 'password',
     database         => 'icinga2_data',
  }

  Icinga2::Object::Host <<| |>> { }

}
