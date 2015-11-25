define profile::jenkins::job(
  $modulename = $title,
  $modulegiturl = ''
) {
  
  jenkins::job { "puppet-module-syntax-${modulename}":
    config => template("profile/puppetmodule-syntax.xml.erb"),
  }  

}