class profile::filebeat::puppetmaster{

 $puppetmasterlogs = hiera_hash('profile::filebeat::puppetmaster::prospector', undef)

  if $puppetmasterlogs {
     create_resources('filebeat::prospector', $puppetmasterlogs)
  } else {
      notify {"No puppet logs configured in filebeat for puppet master instance ${::fqdn}.":}
  }


}

