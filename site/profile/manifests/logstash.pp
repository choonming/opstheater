class profile::logstash{

include profile::filebeat::logstash

$package_url = hiera('profile::logstash::package_url')
$input_beats_port = hiera('profile::logstash::input_beats_port')
$input_beats_type = hiera('profile::logstash::input_beats_type')
$output_elasicsearch_hosts = hiera_array('profile::logstash::output_elasicsearch_hosts', undef)
$output_codec = hiera('profile::logstash::output_codec')


$plugins = hiera_hash('profile::logstash::plugins', undef)


class { 'logstash':
  package_url => $package_url,
  java_install => true,
}


logstash::configfile { 'input_beats':
  content => template('profile/input_beats.erb'),
  order   => 1
}

logstash::configfile { 'filter':
  content => template('profile/filter.erb'),
  order   => 2
}

logstash::configfile { 'output_elasticsearch':
  content => template('profile/output_elasticsearch.erb'),
  order   => 3
}

logstash::configfile { 'output_stdout':
  content => template('profile/output_stdout.erb'),
  order   => 4
}


if $plugins {

    create_resources('logstash::plugin', $plugins)
}

}
