class profile::base::filebeat{

  class { 'filebeat':
    outputs => {
     'logstash' => {
       'hosts'       => [
         'logstash.olindata.vm:5044',
       ],
       'loadbalance' => true,
       'enabled'     => true,
      },
    },
  }
   
  filebeat::prospector { 'syslogs':
    paths    => [
      '/var/log/auth.log',
      '/var/log/messages',
    ],
    log_type => 'syslog-beat',
  }

}
