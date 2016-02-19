class profile::filebeat::logstash{

 $logstashlogs = hiera_hash('profile::filebeat::logstash::prospector', undef)

  if $logstashlogs {
     create_resources('filebeat::prospector', $logstashlogs)
  } else {
     notify {"No logstash log path configured in filebeat for instance ${::fqdn}.":}
  }


}

