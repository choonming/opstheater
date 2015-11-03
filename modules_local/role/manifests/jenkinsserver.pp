class role::jenkinsserver {
  include profile::jenkins::master
  include profile::jenkins::jobs
}