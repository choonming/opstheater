class opstheater::role::puppet::master {
  # Include our standard base packages
  include opstheater::profile::base
  # Add our secure (if specified) foreman proxy via Nginx
  include opstheater::profile::foremanproxy
}
