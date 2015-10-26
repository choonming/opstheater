node 'first' {
  include role::jenkinsserver
}

node 'second' {
  include role::icingaserver
}
