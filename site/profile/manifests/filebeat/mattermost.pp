class profile::filebeat::mattermost{

 $mattermostlogs = hiera_hash('profile::mattermost::filebeat_prospector', undef)

  if $mattermostlogs {
     create_resources('filebeat::prospector', $mattermostlogs)
  } else {
     warning("No mattermost log path configured in filebeat for instance ${::fqdn}.")
  }


}

