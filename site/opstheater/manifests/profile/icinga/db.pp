class opstheater::profile::icinga::db {

  $icinga2_webdb_password = hiera('opstheater::icingaweb::webdb_password')
  $icinga2_ido_password = hiera('opstheater::icinga::ido_password')
  $mysql_whitelist_range = hiera('opstheater::mysql::whitelist_range')

  mysql::db { 'icinga2_web':
    user     => 'icinga2_web',
    password => $icinga2_webdb_password,
    host     => $mysql_whitelist_range,
    grant    => ['ALL'],
  }

  mysql::db { 'icinga2_data':
    user     => 'icinga2',
    password => $icinga2_ido_password,
    host     => $mysql_whitelist_range,
    grant    => ['ALL'],
  }

}