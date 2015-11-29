node 'master' {
  include role::puppet::master
}

}

}

node 'icinga2' {
  include role::icinga::server
}

node 'icingaweb2' {
  include role::icinga::web
}

node 'elasticsearch' {
  include role::elastic::server
}

node 'gitlab' {
  include role::gitlab::server
}


