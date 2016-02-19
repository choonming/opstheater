class profile::filebeat::foreman{

 $foremanlogs = hiera_hash('profile::filebeat::foreman::prospector', undef)

  if $foremanlogs {
     create_resources('filebeat::prospector', $foremanlogs)
  } else {
     notify {"No foreman log path configured in filebeat for instance ${::fqdn}."}
  }


}

