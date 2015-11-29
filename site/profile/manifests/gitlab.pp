class profile::gitlab {

  # NOTE: it shouldn't be needed to define the user and file resources here, this should be 
  # fixed in the omnibus installer
  user { 'gitlab-ci':
    comment => 'Gitlab CI user',
    home    => '/var/opt/gitlab/gitlab-ci',
    ensure  => present,
    shell  => '/bin/false',
  } ->

  file { '/var/opt/gitlab/nginx':
    ensure => directory,
  } ->
  file { '/var/opt/gitlab/nginx/conf':
    ensure => directory,
  } ->

  class { '::gitlab':
    external_url            => 'http://gitlab.olindata.vm',
    ci_external_url         => 'http://ci.olindata.vm',
    mattermost_external_url => 'http://chat.olindata.vm'
  }

  host { ['gitlab.olindata.vm', 'ci.olindata.vm', 'chat.olindata.vm']:
    ensure => present,
    ip     => $facts['networking']['interfaces']['enp0s8']['ip'],
  }

}