class role::monitoring::standalone {
  include profile::base
  include profile::icinga::web
  include profile::icinga::server
}
