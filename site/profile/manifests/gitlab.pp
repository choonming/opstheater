class profile::gitlab {

  $gitlab_url      = hiera('profile::gitlab::gitlab_url')
  $gitlab_fqdn     = hiera('profile::gitlab::gitlab_fqdn')
  $gitlabci_url    = hiera('profile::gitlab::gitlabci_url')
  $gitlabci_fqdn   = hiera('profile::gitlab::gitlabci_fqdn')
  $mattermost_url  = hiera('profile::gitlab::mattermost_url')
  $mattermost_fqdn = hiera('profile::gitlab::mattermost_fqdn')

  $gitlab_api_endpoint = hiera('profile::gitlab::api_endpoint')
  $gitlab_api_user     = hiera('profile::gitlab::api_user')
  $gitlab_api_password = hiera('profile::gitlab::api_password')

  host { [$gitlab_fqdn, $gitlabci_fqdn, $mattermost_fqdn]:
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
    mode   => '0700',
  } ->
  file { "/etc/gitlab/ssl/${gitlab_fqdn}.key" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlab.key",
    notify => Exec['gitlab_reconfigure'],
  } ->
  file { "/etc/gitlab/ssl/${gitlab_fqdn}.crt" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlab.crt",
    notify => Exec['gitlab_reconfigure'],
  } ->

  file { "/etc/gitlab/ssl/${gitlabci_fqdn}.key" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlabci.key",
    notify => Exec['gitlab_reconfigure'],
  } ->
  file { "/etc/gitlab/ssl/${gitlabci_fqdn}.crt" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/gitlabci.crt",
    notify => Exec['gitlab_reconfigure'],
  } ->

  file { "/etc/gitlab/ssl/${mattermost_fqdn}.key" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/mattermost.key",
    notify => Exec['gitlab_reconfigure'],
  } ->
  file { "/etc/gitlab/ssl/${mattermost_fqdn}.crt" :
    ensure => file,
    source => "puppet:///modules/profile/gitlab_ssl/mattermost.crt",
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
    external_url            => $gitlab_url,
    ci_external_url         => $gitlabci_url,
    mattermost_external_url => $mattermost_url,
  } ->

  class { '::gitlab::cli':
    gitlab_api_endpoint     => $gitlab_api_endpoint,
    gitlab_api_password     => $gitlab_api_password,
    gitlab_api_user         => $gitlab_api_user,
    manage_cli_dependencies => true,
  } ->

  gitlab::user { 'walter-test':
    username => 'walterheck',
    email    => 'walterheck@olindata.com',
    password => 'alkgrcfnal',
    fullname => 'Walter Heck',
  }


}
