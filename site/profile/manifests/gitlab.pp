class profile::gitlab {
  class { '::gitlab':
    external_url            => 'http://gitlab.olindata.vm',
    ci_external_url         => 'http://ci.olindata.vm',
    mattermost_external_url => 'http://chat.olindata.vm'
  }

  host { ['gitlab.olindata.vm', 'ci.olindata.vm', 'chat.olindata.vm']:
    ensure => present,
    ip     => $facts['networking']['interfaces']['enp0s8'],
  }

}