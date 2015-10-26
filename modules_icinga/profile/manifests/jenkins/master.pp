class profile::jenkins::master {
  package {'java-1.7.0-openjdk.x86_64':
    ensure => 'present',
  }
  ->
  # RHEL5 Workaround for RPM key
  # See https://groups.google.com/forum/?fromgroups#!topic/puppet-users/Yxiekm0j1J4
  rpmkey { 'D50582E6':
    ensure => present,
    source => 'http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key',
  }
  ->
  class {'jenkins':
    install_java => false,
    cli          => true,
  }
  ->
  jenkins::plugin { 'git': 
  }
  jenkins::plugin { 'ws-cleanup': 
  }
}