class profile::filebeat::logstash{

 $logstashlogs = hiera_hash('profile::logstash::filebeat_prospector', undef)

  if $logstashlogs {
     create_resources('filebeat::prospector', $logstashlogs)
  } else {
     warning("No logstash log path configured in filebeat for instance ${::fqdn}.")
  }


}

