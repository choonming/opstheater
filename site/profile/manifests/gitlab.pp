class profile::gitlab {

  host { ['gitlab.olindata.vm', 'ci.olindata.vm', 'chat.olindata.vm']:
    ensure => present,
    ip     => $facts['networking']['interfaces']['enp0s8']['ip'],
  } ->

  # NOTE: it shouldn't be needed to define the user and file resources here, this should be 
  # fixed in the omnibus installer
  user { 'gitlab-ci':
    comment => 'Gitlab CI user',
    home    => '/var/opt/gitlab/gitlab-ci',
    ensure  => present,
    shell   => '/bin/false',
  } ->

  # Some ssl keys for gitlab
  file { ['/etc/gitlab', '/etc/gitlab/ssl'] :
    ensure => directory,
  } ->
  file { "/etc/gitlab/ssl/${::fqdn}.key" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlab.key",
    notify => Exec['gitlab_reconfigure'],
  } ->
  file { "/etc/gitlab/ssl/${::fqdn}.crt" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlab.crt",
    notify => Exec['gitlab_reconfigure'],
  } ->

  # make sure some of the basic directories exist
  file { '/var/opt/gitlab':
    ensure => directory,
    notify => Exec['gitlab_reconfigure']
  } ->
  file { '/var/opt/gitlab/nginx':
    ensure => directory,
  } ->
  file { '/var/opt/gitlab/nginx/conf':
    ensure => directory,
  } ->

  # configure gitlab. The *_url attributes determine wether that subsystem should be configured
  class { '::gitlab':
    external_url            => 'https://gitlab.olindata.vm',
    ci_external_url         => 'http://ci.olindata.vm',
    mattermost_external_url => 'http://chat.olindata.vm',
  } ->

  # set up the gitlab gem to have gitlab cli support
  package { 'gitlab':
     ensure   => installed,
     provider => 'gem',
     require  => [ Package['rubygems'], Package['ruby-devel'] ]
   } 

}
