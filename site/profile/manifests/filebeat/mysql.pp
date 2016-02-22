class profile::filebeat::mysql{

  $mysqllogs = hiera_hash('profile::filebeat::mysql::prospector', undef)

  if $kibanalogs {
     create_resources('filebeat::prospector', $mysqllogs)
  } else {
     notify {"No mysql log path configured in filebeat for instance ${::fqdn}.":}
  }


}

