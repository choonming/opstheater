class profile::base {
  
  # configure ntp
  include ::ntp

  # we use melbourne's firewall
  class { 'firewall':
    ensure => stopped,
  }

  # configure ssh
  include ::ssh::client
  include ::ssh::server

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

  # some packages can not be loaded from hiera_hash because then we can't require them elsewhere
  package { ['ruby-devel', 'rubygems']:
    ensure => present,
  }
}