class role::icinga::server {
  include profile::base
  include profile::icinga::server
  include profile::icinga::web
}