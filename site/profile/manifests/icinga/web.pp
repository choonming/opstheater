class profile::icinga::web {

  if ! defined (Class['epel']) {
    class { 'epel': }
  }

  class { '::mysql::client': }

  class { 'apache': } 
  
  class { 'apache::mod::php': } 

  package { 'php-Icinga':
    ensure  => latest,
    require   => [ Class['epel'], Package['php-ZendFramework'], Package['php-ZendFramework-Db-Adapter-Pdo-Mysql'] ],
    alias   => 'php-Icinga'
  }

  package { 'icingacli':
    ensure  => latest,
    require   => [ Class['epel'], Package['php-ZendFramework'], Package['php-ZendFramework-Db-Adapter-Pdo-Mysql'] ],
    alias   => 'icingacli'
  }

  package { ['php-ZendFramework', 'php-ZendFramework-Db-Adapter-Pdo-Mysql']:
    ensure  => latest,
  } ->

  class { 'icingaweb2':
    manage_repo    => true,
    install_method => 'package',
    manage_apache_vhost => true,
    apache_vhost_name => 'icinga.olindata.com',
    ido_db  => 'mysql',
    ido_db_host => 'localhost',
    ido_db_name => 'icinga2_data',
    ido_db_user => 'icinga2',
    ido_db_pass => 'password',
    ido_db_port => '3306',
    web_db      => 'mysql',
    web_db_name => 'icinga2_web',
    web_db_host => 'localhost',
    web_db_user => 'icinga2_web',
    web_db_pass => 'password',
    web_db_port => '3306',
  }

  exec { 'populate-icinga2_web-mysql-db':
    path  => '/bin:/usr/bin:/sbin:/usr/sbin',
    unless    => 'mysql -h localhost -uicinga2_web -ppassword icinga2_web -e "SELECT * FROM icingaweb_user;" &> /dev/null',
    command   => 'mysql -h localhost -uicinga2_web -ppassword icinga2_web < /usr/share/doc/icingaweb2/schema/mysql.schema.sql; mysql -h localhost -uicinga2_web -ppassword icinga2_web -e "INSERT INTO icingaweb_user (name, active, password_hash) VALUES (\'icingaadmin\', 1, \'\$1\$iQSrnmO9\$T3NVTu0zBkfuim4lWNRmH.\');"',
    require   => [ Class['::mysql::client'], Package['icingaweb2'] ],
  } ->

  file { '/etc/icingaweb2/enabledModules/monitoring':
    ensure  => 'link',
    target  => '/usr/share/icingaweb2/modules/monitoring',
  }

  file { "/etc/icingaweb2/modules/monitoring":
    ensure=> 'directory',
    mode  => '2770',
    owner => 'root',
    group => 'icingaweb2',
  }

  file { "/etc/icingaweb2/modules/monitoring/backends.ini":
    ensure=> 'file',
    mode  => '0770',
    owner => 'root',
    group => 'icingaweb2',
    content   => "[icinga2]\ntype = \"ido\"\nresource = \"icinga_ido\"\n",
  }

  file { "/etc/icingaweb2/modules/monitoring/config.ini":
    ensure=> "file",
    mode  => "0770",
    owner => "root",
    group => "icingaweb2",
    content   => "[security]\nprotected_customvars = \"*pw*,*pass*,community\"\n",
  }

  file { "/etc/icingaweb2/modules/monitoring/commandtransports.ini":
    ensure=> "file",
    mode  => "0770",
    owner => "root",
    group => "icingaweb2",
    content => "[icinga2]\ntransport = \"local\"\npath = \"/var/run/icinga2/cmd/icinga2.cmd\"\n",
  }

}
