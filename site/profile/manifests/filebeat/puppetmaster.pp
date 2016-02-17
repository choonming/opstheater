class profile::filebeat::puppetmaster{

 $puppetmasterlogs = hiera_hash('profile::puppetmaster::filebeat_prospector', undef)

  if $puppetmasterlogs {
     create_resources('filebeat::prospector', $puppetmasterlogs)
  } else {
     warning("No puppet logs configured in filebeat for puppet master instance ${::fqdn}.")
  }


}

