node 'first' {
  include role::jenkinsserver
}

node 'second' {
  include role::icingaserver
}

node 'third' {
  include role::jenkinsslave
}
