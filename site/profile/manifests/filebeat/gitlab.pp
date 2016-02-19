class profile::filebeat::gitlab{

 $gitlablogs = hiera_hash('profile::filebeat::gitlab::prospector', undef)

  if $gitlablogs {
     create_resources('filebeat::prospector', $gitlablogs)
  } else {
     notify {"No gitlab log path configured in filebeat for instance ${::fqdn}.":}
  }


}

