class profile::filebeat::apache{

 $apachelogs = hiera_hash('profile::filebeat::apache::prospector', undef)

  if $apachelogs {
     create_resources('filebeat::prospector', $apachelogs)
  } else {
     notify {"No apache log path configured in filebeat for instance ${::fqdn}.":}
  }


}
