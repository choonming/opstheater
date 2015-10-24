class profile::icinga::server {

  class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
  }->
  
  class { 'postgresql::server': }->
  
  postgresql::server::db { 'icinga2_data':
    user     => 'icinga2',
    password => postgresql_password('icinga2', 'password'),
  }->

  class { 'icinga2::server':
    db_type => 'pgsql',
    db_host => 'localhost',
    db_port => '5432',
    db_name => 'icinga2_data',
    db_user => 'icinga2',
    db_pass => 'password',
  }->
  icinga2::object::idopgsqlconnection { 'postgres_connection':
     target_dir => '/etc/icinga2/features-enabled',
     target_file_name => 'ido-pgsql.conf',
     host             => '127.0.0.1',
     port             => 5432,
     user             => 'icinga2',
     password         => 'password',
     database         => 'icinga2_data',
  }
}