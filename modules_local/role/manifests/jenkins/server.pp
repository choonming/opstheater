class role::jenkins::server {
  include profile::jenkins::master
  include profile::jenkins::jobs
}