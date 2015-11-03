node 'first' {
  include role::jenkinsserver
}

node 'second' {
  include role::jenkinsslave
}

node 'third' {
  include role::icingaserver
}

