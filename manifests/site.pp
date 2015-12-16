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


#### TODO: these machines haven't been puppetised yet
node 'icinga2' {
  include role::icinga::server
}

node 'icingaweb2' {
  include role::icinga::web
}

node 'testclient' {
  include role::testclient
}
