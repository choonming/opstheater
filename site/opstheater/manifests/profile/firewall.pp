class opstheater::profile::firewall {

  $purge_firewalls = hiera('opstheater::purge_firewalls', true)
  $purge_firewallchains = hiera('opstheater::purge_firewallchains', true)
  $ip_whitelist = hiera('opstheater::ip_whitelist', undef)

  include ::firewall
  include ::opstheater::profile::firewall::pre
  include ::opstheater::profile::firewall::post

  resources { 'firewall':
    purge => $purge_firewalls,
  }

  resources { 'firewallchain':
    purge => $purge_firewallchains,
  }

  firewallchain { 'OPSTHEATER:filter:IPv4':
    ensure => present,
    purge  => true,
  }

  $ip_list = unique($ip_whitelist)
  $ip_list.each | String $ip | {
    firewall { "100 accept connections for ${ip}":
      chain  => 'OPSTHEATER',
      action => 'accept'
      proto  => 'all',
      source => $ip,
    }
  }

  Firewall <| tag == 'opstheater' |>

  Firewall {
    before  => Class['opstheater::profile::firewall::pre']
    require => Class['opstheater::profile::firewall::post']
  }

}
