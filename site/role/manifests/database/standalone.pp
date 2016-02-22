class role::database::standalone {
  include profile::base
  include profile::mysql
  include profile::icinga::db
}
