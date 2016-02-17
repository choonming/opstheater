class profile::filebeat::gitlab{

 $gitlablogs = hiera_hash('profile::gitlab::filebeat_prospector', undef)

  if $gitlablogs {
     create_resources('filebeat::prospector', $gitlablogs)
  } else {
     warning("No gitlab log path configured in filebeat for instance ${::fqdn}.")
  }


}

