# runs puppet enterprise for now
node 'master' {
  include role::puppet::master
}

# runs elasticsearch and kibana
node 'elasticsearch' {
  include role::elastic::server
}

# runs gitlab, gitlab CI and mattermost
node 'gitlab' {
  include role::gitlab::server
}

# runs standalone monitoring setup with icinga2 and icinga web2
node 'icinga2' {
  include role::monitoring::standalone
}

node 'mysql' {
  include role::database::standalone
}

node default {
  include role::testclient
}
