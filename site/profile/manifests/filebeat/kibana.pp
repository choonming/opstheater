class profile::filebeat::kibana{

 $kibanalogs = hiera_hash('profile::kibana::filebeat_prospector', undef)

  if $kibanalogs {
     create_resources('filebeat::prospector', $kibanalogs)
  } else {
     warning("No kibana log path configured in filebeat for instance ${::fqdn}.")
  }


}

