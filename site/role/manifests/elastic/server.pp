class role::elastic::server {

  include profile::base  
  include profile::elasticsearch
  include profile::kibana

}