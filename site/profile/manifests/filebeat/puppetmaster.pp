class profile::filebeat::puppetmaster{

 $puppetmasterlogs = hiera_hash('profile::filebeat::puppetmaster::prospector', undef)

  if $puppetmasterlogs {
     create_resources('filebeat::prospector', $puppetmasterlogs)
  } else {
      notify {"No puppet logs configured in filebeat for puppet master instance ${::fqdn}.":}
  }
profile::filebeat::puppetmaster::prospector:  
  puppetserverlogs:
    paths:
      - '/var/log/puppetlabs/puppetserver/puppetserver.log'
      - '/var/log/puppetlabs/puppetserver/puppetserver-access.log'
    log_type: 'puppetserver-beat'
  puppetdblogs:
    paths:
      - '/var/log/puppetlabs/puppetdb/puppetdb.log'
      - '/var/log/puppetlabs/puppetdb/puppetdb-access.log'
    log_type: 'puppetdb-beat'
  puppetcslogs:
    paths:
      - '/var/log/puppetlabs/console-services/console-services.log'
      - '/var/log/puppetlabs/console-services/console-services-access.log'
    log_type: 'puppetcs-beat'
  nginxlogs:
    paths:
      - '/var/log/puppetlabs/nginx/access.log'
      - '/var/log/puppetlabs/nginx/error.log'
    log_type: 'nginx-beat'


}

