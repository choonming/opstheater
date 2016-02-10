class opstheater::profile::icinga::client {

  $icinga2_web_fqdn = hiera('opstheater::icingaweb::fqdn')

  include ::icinga2
  include ::icinga2::feature::command
  include ::icinga2::pki::puppet

  class { '::icinga2::feature::api':
    accept_commands => true,
    accept_config   => true,
    manage_zone     => false,
  }

  @@icinga2::object::zone { $::fqdn:
    endpoints => {
      $::fqdn => {
        host => $::fqdn,
      },
    },
    parent    => 'master',
  }

  Icinga2::Object::Zone <<| |>>

}
