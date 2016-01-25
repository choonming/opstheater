class profile::base {
  
  # configure ntp
  include ::ntp

  # TODO: this needs to be enabled
  class { 'firewall':
    ensure => stopped,
  }

  # configure ssh
  include ::ssh::client
  include ::ssh::server

  # configure filebeat
  include profile::base::filebeat

  # depending on the OS, include apt or yum repos
  case $::osfamily {
    'debian' : { include profile::base::apt }
    'redhat' : { include profile::base::yum }
    default  : { fail("Unsupported Operating System family : ${::osfamily}") }
  }

  # load other network interfaces from hiera
  $packages = hiera_hash('profile::base::packages', undef)
  if $packages {
    create_resources('package', $packages)
  }

  # apply basic icinga checks to servers
  if $::hostname != 'icinga2' {
    include profile::base::icinga
  }

}
