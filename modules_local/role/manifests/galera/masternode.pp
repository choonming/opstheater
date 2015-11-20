class role::galera::masternode {
  
  include profile::base  

  include profile::mysql::galera
  include profile::logrotate  

  include profile::haproxy::galera
}