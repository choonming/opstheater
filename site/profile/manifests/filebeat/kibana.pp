class profile::filebeat::kibana{

 $kibanalogs = hiera_hash('profile::filebeat::kibana::prospector', undef)

  if $kibanalogs {
     create_resources('filebeat::prospector', $kibanalogs)
  } else {
     notify {"No kibana log path configured in filebeat for instance ${::fqdn}.":}
  }


}

