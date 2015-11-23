class profile::kibana {

  #It is compulsory to create source and destination directory, and to give access to the kibana4_user on those directories
  #here /etc/kibana is target directory and /usr/src/kibana is source directory

  file {[hiera('profile::kibana::install_dir'),hiera('profile::kibana::src_target')]:
    ensure => 'directory',
    owner  => hiera('profile::kibana::kibana4_user'),
    group  => hiera('profile::kibana::kibana4_group'),
    mode   => '755'
  } ->

  class { 'kibana4':
    manage_user          => hiera('profile::kibana::manage_user'),
    kibana4_user         => hiera('profile::kibana::kibana4_user'),
    kibana4_group        => hiera('profile::kibana::kibana4_group'),
    kibana4_gid          => hiera('profile::kibana::kibana4_gid'),
    kibana4_uid          => hiera('profile::kibana::kibana4_uid'),
    package_ensure       => hiera('profile::kibana::package_ensure'),
    repo_version         => hiera('profile::kibana::repo_version'),
    install_dir          => hiera('profile::kibana::install_dir'),
    symlink              => hiera('profile::kibana::symlink'),
    package_provider     => hiera('profile::kibana::package_provider'),
    package_download_url => hiera('profile::kibana::package_download_url'),
    port                 => hiera('profile::kibana::port'),
    elasticsearch_url    => hiera('profile::kibana::elasticsearch_url'),
    host                 => "${::ipaddress_eth0}",
  } 

}