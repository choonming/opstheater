class opstheater::profile::ssh {

  include ::ssh::server
  include ::ssh::client

  @@firewall { '010 allow SSH access':
    chain   => 'INPUT',
    action  => 'allow',
    proto   => 'tcp',
    dport   => '22',
    source  => hiera('opstheater::vpn_ip', '0.0.0.0'),
    tag     => 'opstheater',
  }

}
