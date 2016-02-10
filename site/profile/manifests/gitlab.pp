class profile::gitlab {

  $gitlab_url                 = hiera('profile::gitlab::gitlab_url')
  $gitlab_fqdn                = hiera('profile::gitlab::gitlab_fqdn')
  $gitlab_ipaddress           = hiera('profile::gitlab::gitlab_ipaddress')
  $gitlabci_url               = hiera('profile::gitlab::gitlab_url')
  $gitlab_smtp_authentication = ( if hiera('opstheater::smtp::auth_type') in (['none','login','plain']) { hiera('opstheater::smtp::auth_type') } else { 'none' } )
  $gitlab_enable_tls          = ( if hiera('opstheater::smtp::ssl_type') in (['TLS','STARTTLS']) == true { true } else { false })
  $gitlab_starttls_auto       = ( if hiera('opstheater::smtp::ssl_type') == 'STARTTLS' { true } else { false } )

  $mattermost_url                 = hiera('profile::gitlab::mattermost_url')
  $mattermost_fqdn                = hiera('profile::gitlab::mattermost_fqdn')
  $mattermost_connection_security = ( if hiera('opstheater::smtp::ssl_type') in (['TLS','STARTTLS']) { hiera('opstheater::smtp::ssl_type') } else { false } )

  $email_smtp_username = ( if hiera('opstheater::smtp::auth_type') != false { hiera('opstheater::smtp::username') } else {''} )
  $email_smtp_password = ( if hiera('opstheater::smtp::auth_type') != false { hiera('opstheater::smtp::password') } else {''} )

  $gitlab_api_endpoint = hiera('profile::gitlab::api_endpoint')
  $gitlab_api_user     = hiera('profile::gitlab::api_user')
  $gitlab_api_password = hiera('profile::gitlab::api_password')

  host { [$mattermost_fqdn]:
    ensure => present,
    ip     => $gitlab_ipaddress,
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
  # For SMTP Stuff: http://doc.gitlab.com/omnibus/settings/smtp.html#examples
  class { '::gitlab':
    external_url            => $gitlab_url,
    mattermost_external_url => $mattermost_url,
    mattermost              => {
      team_site_name                        => 'OpsTheater Mattermost by OlinData',
      log_enable_file                       => true, 
      service_enable_incoming_webhooks      => true,
      service_enable_post_username_override => true,
      service_enable_post_icon_override     => true,
      service_enable_outgoing_webhooks      => true,
      email_enable_sign_up_with_email       => false,
      email_smtp_server                     => hiera('opstheater::smtp::fqdn'),    
      email_smtp_username                   => $email_smtp_username,
      email_smtp_password                   => $email_smtp_password,
      email_smtp_port                       => hiera('opstheater::smtp::port'),
      email_connection_security             => $mattermost_connection_security,
      email_feedback_name                   => 'OpsTheater Mattermost',
      email_enable_sign_up_with_email       => false,
      email_feedback_email                  => "mattermost@${mattermost_fqdn}",
      team_enable_team_listing              => true,
      team_enable_team_creation             => false,  #NOTE: This must be TRUE for the initial team to setup mattermost then its always false afterwards
      team_enable_user_creation             => true,
      email_send_email_notifications        => true,
    },
    gitlab_rails            => {
      smtp_enable               => true,
      smtp_address              => hiera('opstheater::smtp::fqdn'),
      smtp_port                 => hiera('opstheater::smtp::port'),
      smtp_user_name            => hiera('opstheater::smtp::username'),
      smtp_password             => hiera('opstheater::smtp::password'),
      smtp_domain               => hiera('opstheater::domain'),
      smtp_authentication       => $gitlab_smtp_authentication,
      smtp_enable_starttls_auto => $gitlab_starttls_auto,
      smtp_tls                  => $gitlab_enable_tls,
      smtp_openssl_verify_mode  => hiera('opstheater::smtp::openssl_verify_mode'),
    },
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
