class role::jenkins::server {
  include profile::base
  include profile::jenkins::master
}