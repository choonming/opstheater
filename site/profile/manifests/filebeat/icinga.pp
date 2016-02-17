class profile::filebeat::icinga{

 $icingalogs = hiera_hash('profile::icinga::filebeat_prospector', undef)

  if $icingalogs {
     create_resources('filebeat::prospector', $icingalogs)
  } else {
     warning("No icinga log path configured in filebeat for instance ${::fqdn}.")
  }


}
