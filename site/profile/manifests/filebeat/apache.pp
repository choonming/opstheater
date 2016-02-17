class profile::filebeat::apache{

 $apachelogs = hiera_hash('profile::apachelogs::filebeat_prospector', undef)

  if $apachelogs {
     create_resources('filebeat::prospector', $apachelogs)
  } else {
     warning("No apache log path configured in filebeat for instance ${::fqdn}.")
  }


}
