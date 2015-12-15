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

}