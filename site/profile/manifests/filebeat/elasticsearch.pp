class profile::filebeat::elasticsearch{

 $elasticlogs = hiera_hash('profile::elasticsearch::filebeat_prospector', undef)

  if $elasticlogs {
     create_resources('filebeat::prospector', $elasticlogs)
  } else {
     warning("No elasticsearch log path configured in filebeat for instance ${::fqdn}.")
  }


}
