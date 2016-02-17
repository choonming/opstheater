class profile::filebeat::mysql{

 $mysqllogs = hiera_hash('profile::mysql::filebeat_prospector', undef)

  if $kibanalogs {
     create_resources('filebeat::prospector', $mysqllogs)
  } else {
     warning("No mysql log path configured in filebeat for instance ${::fqdn}.")
  }


}

