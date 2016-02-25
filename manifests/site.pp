# runs puppet enterprise for now
node 'master.olindata.vm' {
  include opstheater::role::puppet::master
}

# runs elasticsearch and kibana
node 'elasticsearch.olindata.vm' {
  include opstheater::role::elastic::server
}

# runs gitlab, gitlab CI and mattermost
node 'gitlab.olindata.vm' {
  include opstheater::role::gitlab::server
}

# runs standalone monitoring setup with icinga2 and icinga web2
node 'icinga2.olindata.vm' {
  include opstheater::role::monitoring::standalone
}

node 'mysql.olindata.vm' {
  include opstheater::role::database::standalone
}

# runs logstash server
node 'logstash' {
  include opstheater::role::logstash::server
}

node default {
  include opstheater::role::testclient
}

