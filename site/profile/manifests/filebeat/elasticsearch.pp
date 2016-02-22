class profile::filebeat::elasticsearch{

  $elasticlogs = hiera_hash('profile::filebeat::elasticsearch::prospector', undef)

  if $elasticlogs {
     create_resources('filebeat::prospector', $elasticlogs)
  } else {
     notify {"No elasticsearch log path configured in filebeat for instance ${::fqdn}.":}
  }


}
