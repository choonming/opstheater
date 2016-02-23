# runs puppet enterprise for now
node 'master.olindata.vm' {
  include role::puppet::master
}

# runs elasticsearch and kibana
node 'elasticsearch.olindata.vm' {
  include role::elastic::server
}

# runs gitlab, gitlab CI and mattermost
node 'gitlab.olindata.vm' {
  include role::gitlab::server
}

# runs standalone monitoring setup with icinga2 and icinga web2
node 'icinga2.olindata.vm' {
  include role::monitoring::standalone
}

node 'mysql.olindata.vm' {
  include role::database::standalone
}

# runs logstash server
node 'logstash' {
  include role::logstash::server
}

node default {
  include role::testclient
}

