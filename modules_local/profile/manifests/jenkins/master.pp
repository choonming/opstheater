class profile::jenkins::master {
  class {'jenkins':
    install_java => true,
    cli          => true,
  }
  ->
  jenkins::plugin { 'git': 
  }
  jenkins::plugin { 'ws-cleanup': 
  } ->
  include ::jenkins::master
}