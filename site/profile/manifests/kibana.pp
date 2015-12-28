class profile::kibana {
  
  # use the standard kibana4 class, the parameters will be loaded from hiera
  class { '::kibana4':
    elasticsearch_url => 'http://elasticsearch.olindata.vm:9200',
    server_port       => 80,
  } 

}