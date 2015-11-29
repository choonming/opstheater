class profile::filebeat::filebeat{

include stdlib

class {'elastic_filebeat':
        logstash_output_enabled => false,
    }

elastic_filebeat::prospector{'system_logs':
        paths => ['/var/log/messages'],
    }->

if is_array(hiera_array('profile::filebeat::filebeat_output', undef)){

$filebeat_output =  hiera_array('profile::filebeat::filebeat_output', undef)

if 'elasticsearch' in $filebeat_output {

  $elasticsearch_output_enabled = 'true'
  $elasticsearch_hosts = hiera_array('profile::filebeat::elasticsearch_hosts', undef)
 
  concat { '/etc/filebeat/filebeat.yml':
    ensure => present,
    replace => false,
  }
  
  concat::fragment{ 'output_elasticsearch':
    target => '/etc/filebeat/filebeat.yml',
    content => template('profile/filebeat_concat.yaml.erb'),
    order  => '01'
  }
}
}
}
