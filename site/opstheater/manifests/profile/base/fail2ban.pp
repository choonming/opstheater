class opstheater::profile::base::fail2ban {

  class { '::fail2ban':
    jails_config => 'concat',
  }

  fail2ban::jail { 'sshd':
    port      => '22',
    logpath   => '/var/log/audit/auth.log',
    maxretry  => '5',
    bantime   => '600',
  }

}
