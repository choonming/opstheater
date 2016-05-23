Icinga2::Object::Host {
  display_name    => $::fqdn,
  check_command   => 'cluster-zone',
  target_dir      => '/etc/icinga2/objects/hosts',
  target_file_name=> "${::fqdn}.conf",
}

@@icinga2::object::host { $::fqdn:
  ipv4_address => $::ipaddress,
  vars         => {
    os              => 'Linux',
    remote          => true,
    remote_endpoint => $::fqdn
  },
}

$logstash_fqdn = 'elasticsearch.opstheater.vm'

class { 'filebeat':
  outputs => {
    'logstash' => {
      'hosts'  => [
        "${logstash_fqdn}:5044",
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


filebeat::prospector { 'icingalogs':
  paths    => [
    '/var/log/icinga2/icinga2.log',
    '/var/log/icinga2/error.log',
  ],
  log_type => 'icinga-beat',
}

$icinga2_web_fqdn = 'icinga2.opstheater.vm'

class { 'icinga2': }
class { 'icinga2::feature::command': }
include ::icinga2
include ::icinga2::feature::command

class { '::icinga2::feature::api':
  accept_commands => true,
  accept_config   => true,
  manage_zone     => false,
}

# icinga2::pki::puppet class needs to be declared
# after the icinga2::feature::api class in order
# to avoid resource duplication

contain ::icinga2::pki::puppet

@@icinga2::object::zone { $::fqdn:
  endpoints => {
    $::fqdn => {
      host => $::fqdn,
    },
  },
  parent    => 'master',
}

icinga2::object::zone { 'master':
  endpoints => {
    $icinga2_web_fqdn => {
      host => $icinga2_web_fqdn,
    },
  },
}

Icinga2::Object::Zone <<| |>>

