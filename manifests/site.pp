node 'master' {
  include role::puppet::master
}

node 'jenkins' {
  include role::jenkins::server
}

node 'jenkinsslave' {
  include role::jenkins::slave
}

node 'icinga2' {
  include role::icinga::server
}

node 'galera001' {
  include role::galera::masternode
}

node 'galera002' {
  include role::galera::node
}

node 'galera003' {
  include role::galera::node
}

node 'icingaweb2' {
  include role::icinga::web
}

node 'zulip' {
  include role::zulip::server
}

node 'elasticsearch' {
  include role::elastic::server
}

node 'gitlab' {
  include role::gitlab::server
}


