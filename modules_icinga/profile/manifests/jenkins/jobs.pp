class profile::jenkins::jobs {
  jenkins::job { 'puppet-module-syntax-jenkins':
    config => template("profile/puppetmodule-syntax.xml.erb"),
  }
}