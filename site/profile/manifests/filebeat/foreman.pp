class profile::filebeat::foreman{

 $foremanlogs = hiera_hash('profile::foreman::filebeat_prospector', undef)

  if $foremanlogs {
     create_resources('filebeat::prospector', $foremanlogs)
  } else {
     warning("No foreman log path configured in filebeat for instance ${::fqdn}.")
  }


}

