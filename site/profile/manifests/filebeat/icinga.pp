class profile::filebeat::icinga{

 $icingalogs = hiera_hash('profile::filebeat::icinga::prospector', undef)

  if $icingalogs {
     create_resources('filebeat::prospector', $icingalogs)
  } else {
     notify {"No icinga log path configured in filebeat for instance ${::fqdn}.":}
  }


}
