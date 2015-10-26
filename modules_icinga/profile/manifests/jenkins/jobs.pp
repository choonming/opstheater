class profile::jenkins::jobs {
  jenkins::job { 'puppet-module-syntax-jenkins':
    config => template("templates/puppetmodule-syntax.xml.erb"),
  }
}