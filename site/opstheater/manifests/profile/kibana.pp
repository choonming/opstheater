class opstheater::profile::kibana {
  
  $elasticsearch = hiera('opstheater::elasticsearch::fqdn')

  # use the standard kibana4 class, the parameters will be loaded from hiera
  class { '::kibana4':
    elasticsearch_url => "http://${elasticsearch}:9200",
  }

  include opstheater::profile::filebeat::kibana

  @firewall { '208 allow HTTP access to kibana':
    chain   => 'INPUT',
    action  => 'accept',
    proto   => 'tcp',
    dport   => '5601',
    source  => hiera('opstheater::vpn_ip', '0.0.0.0'),
    tag     => 'opstheater',
  }
}
