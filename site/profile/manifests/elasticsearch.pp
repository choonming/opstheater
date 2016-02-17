#class profile::elasticsearch inherits profile::base{

class profile::elasticsearch{  
  # resources required for elasticsearch
  include ::java
  include profile::filebeat::elasticsearch
  include profile::filebeat::kibana 
  
  class { '::elasticsearch':
  }
  
  # load elasticsearch instance details fore hiera
  $instances = hiera_hash('profile::elasticsearch::instances', undef)
#  $elasticlogs= hiera_hash('profile::elasticsearch::filebeat_prospector', undef) 
 
  if $instances {
    create_resources('elasticsearch::instance', $instances)
  } else {
    fail("No elasticsearch instances found in hiera for class profile::elasticsearch on ${::fqdn}.")
  }
    
}
