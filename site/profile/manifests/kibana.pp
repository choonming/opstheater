class profile::kibana {
  
  # use the standard kibana4 class, the parameters will be loaded from hiera
  class { '::kibana4':
  } 

}