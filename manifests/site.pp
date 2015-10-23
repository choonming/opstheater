node 'first' {
  include role::icingaserver
}

node 'second' {
  include role::testnode
}

node default {
  fail("This node ${::certname} has no classes assigned to it!")
}