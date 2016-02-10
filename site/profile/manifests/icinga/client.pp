class profile::icinga::client {

  $icinga2_web_fqdn = hiera('opstheater::icingaweb::fqdn')

  include ::icinga2
  include ::icinga2::feature::command

  class { '::icinga2::feature::api':
    accept_commands => true,
    accept_config   => true,
    manage_zone     => false,
  }

  include ::icinga2::pki::puppet

  @@icinga::object::zone { $::fqdn:
    endpoints => {
      $::fqdn => {
        host  => $::fqdn,
      },
    },
    parent    => 'master',
  }

  Icinga2::Object::Zone <<| |>>

}
