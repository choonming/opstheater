class profile::mysql {
  include ::mysql::client

  $override_options = hiera_hash('profile::mysql::override_options', undef)

  class { '::mysql::server':
      package_ensure   => 'present',
      override_options => $override_options,
      require          => [Package['mysql_client']]
  }

  package { [ 'percona-toolkit', 'percona-xtrabackup' ]:
    ensure => latest,
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-percona':
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    source => "puppet:///modules/profile/mysql/RPM-GPG-KEY-percona.txt",
    before => [Package['mysql_client']],
  }

  file { '/var/log/mysql':
    ensure => 'directory',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '0755',
    before => [Package['mysql_client']],
  }

}

