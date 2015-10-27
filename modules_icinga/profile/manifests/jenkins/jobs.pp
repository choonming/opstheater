class profile::jenkins::jobs {

  profile::jenkins::job { 'jenkins':
    modulename   => 'jenkins',
    modulegiturl => 'https://github.com/jenkinsci/puppet-jenkins.git',
  }
  profile::jenkins::job { 'mysql':
    modulename => 'mysql',
    modulegiturl => 'https://github.com/puppetlabs/puppetlabs-mysql.git',
  }
  profile::jenkins::job { 'apache':
    modulename => 'apache',
    modulegiturl => 'https://github.com/puppetlabs/puppetlabs-apache.git',
  }


}