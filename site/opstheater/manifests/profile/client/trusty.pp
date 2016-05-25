class opstheater::profile::client::trusty {
  include opstheater::profile::base::filebeat

  include opstheater::profile::base::icinga
  include opstheater::profile::icinga::client

  $rand1 = fqdn_rand(30)
  $rand2 = $rand1 + 30

  cron { 'Puppet agent run':
    command => '/opt/puppetlabs/bin/puppet agent --onetime --no-daemonize',
    user    => 'root',
    minute  => [ $rand1, $rand2],
  }

}