class profile::logstash{

class { 'logstash':
  package_url => 'https://download.elastic.co/logstash/logstash/packages/centos/logstash-2.1.1-1.noarch.rpm',
  java_install => true,
}

logstash::configfile { 'input_beats':
  content => template('profile/input_beats.erb'),
  order   => 1
}

#logstash::configfile { 'filter_apache':
#  source => 'puppet:///path/to/filter_apache',
#  order  => 2
#}

logstash::configfile { 'output_elasticsearch':
  content => template('profile/output_elasticsearch.erb'),
  order   => 3
}

logstash::configfile { 'output_stdout':
  content => template('profile/output_stdout.erb'),
  order   => 4
}


logstash::plugin { 'beats':
  ensure => 'present',
  type   => 'input',
  source => 'puppet:///modules/profile/logstash/beats.rb',
}

logstash::plugin { 'elasticsearch':
  ensure   => 'present',
  type     => 'output',
  source   => 'puppet:///modules/profile/logstash/elasticsearch.rb',
  filename => 'elasticsearch.rb',
}

}
