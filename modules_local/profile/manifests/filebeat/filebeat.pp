class profile::filebeat::filebeat{

class {'elastic_filebeat':
        output => ['elasticsearch'],
        elasticsearch_output_enabled => true,
        elasticsearch_output_hosts => ['192.168.138.160:9200'],
        paths => ['/var/log/messages'],
    }

}
