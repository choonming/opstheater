class role::gitlab::server {
  include profile::base  

  include profile::gitlab

  gitlab::user { 'walter-test':
    username => 'walterheck',
    email    => 'walterheck@olindata.com',
    password => 'alkgrcfnal',
    fullname => 'Walter Heck',
  }
}