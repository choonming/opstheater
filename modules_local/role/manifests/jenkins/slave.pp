class role::jenkins::slave {
  include profile::base
  include profile::jenkins::slave
  include profile::jenkins::jobs
}