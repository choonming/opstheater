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

  user { 'opstheater':
    ensure      => present,
    comment     => 'OpsTheater Infra',
    shell       => '/bin/bash',
    managehome  => true,
  }

  ssh_authorized_key { 'opstheater':
    user  => 'opstheater',
    type  => 'ssh-rsa',
    key   => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDBgMhKw6sIw50udszZbrtqO6svbrvjzjLGtURpfk52IWXqOib5tNC8HJtSUOyu4euY0QlpoLxGdnE5wDhfG8dWgFo9DAhONJ4alQkq7RxBLY3FF+W01PWVLV4lwdumCQ9XgrcXdG4MiVtWVyZdbabqltgNZILlEvtpCGpAiptEdSTek5eSV5wVF/mHyVMa/DLBTh2CNhxeG0//8vMurxFRgLGhg7u7bj3lqcPwMoiCaX9cnalPqQ3WryoobwfykHqvCLUhM0fpbkNAB+K5j3qK5SOlRxs9JMxcMjPNGqkcfQ3hCpnfhDwQLfjFliaG0yACxQTujg6jrqNdk4FW0FEx',
  }

}
