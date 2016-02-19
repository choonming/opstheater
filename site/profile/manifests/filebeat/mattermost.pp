class profile::filebeat::mattermost{

 $mattermostlogs = hiera_hash('profile::filebeat::mattermost::prospector', undef)

  if $mattermostlogs {
     create_resources('filebeat::prospector', $mattermostlogs)
  } else {
     notify {"No mattermost log path configured in filebeat for instance ${::fqdn}.":}
  }


}

