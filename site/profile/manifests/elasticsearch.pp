class profile::elasticsearch{
  # resources required for elasticsearch
  include ::java
  include profile::filebeat::elasticsearch
  
  class { '::elasticsearch':
  }
  
  # load elasticsearch instance details fore hiera
  $instances = hiera_hash('profile::elasticsearch::instances', undef)
 
  if $instances {
    create_resources('elasticsearch::instance', $instances)
  } else {
    fail("No elasticsearch instances found in hiera for class profile::elasticsearch on ${::fqdn}.")
  }
    
}
