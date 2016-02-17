class role::puppet::master {
  # Include our standard base packages
  include profile::base
  # Add our secure (if specified) foreman proxy via Nginx
  include profile::foremanproxy

  include profile::filebeat::puppetmaster 
}
