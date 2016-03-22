### Prerequisites

* Make sure you have installed the following on your host machine:

  * virtualbox (http://virtualbox.org)

  * vagrant (https://www.vagrantup.com/)

  * vagrant plugin oscar (https://github.com/oscar-stack/oscar)

* Download the Puppet enterprise installer you will use at least for the master (by default this is PE 2015.2.2 on CentOS 7):
  
  * PE 2015.2.0:
  
    * https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-ubuntu-14.04-amd64.tar.gz

    * https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz

    * https://s3.amazonaws.com/pe-builds/released/2015.2.0/puppet-enterprise-2015.2.0-el-6-x86_64.tar.gz

  * PE 2015.2.2:

    * https://s3.amazonaws.com/pe-builds/released/2015.2.2/puppet-enterprise-2015.2.2-ubuntu-14.04-amd64.tar.gz

    * https://s3.amazonaws.com/pe-builds/released/2015.2.2/puppet-enterprise-2015.2.2-el-7-x86_64.tar.gz

    * https://s3.amazonaws.com/pe-builds/released/2015.2.2/puppet-enterprise-2015.2.2-el-6-x86_64.tar.gz

  * PE 2015.3.0:

    * https://s3.amazonaws.com/pe-builds/released/2015.3.0/puppet-enterprise-2015.3.0-el-7-x86_64.tar.gz


### Setting up opscentre in an oscar environment

* First of all install oscar plugin for vagrant with following command :
  
  ```
  vagrant plugin install oscar
  ```
  
  Please note that you need to run vagrant command from the location of your Vagrantfile 
  in this case location of Vagrantfile is : `~/opscenter-oscar/`

* Clone this repository on your host machine and initiate the submodules also:
  
  ```
  git clone git@github.com:olindata/opscenter-oscar.git
  cd opscenter-oscar/
  git submodule update --init
  ```

* Use the pe-build plugin that comes with oscar to place the downloaded puppet enterprise installer in the correct location on your host.

  
  `vagrant pe-build copy /path/to/puppet-enterprise-2015.2.0-el-7-x86_64.tar.gz`
  
  Make sure to update the version of PE you are using in the `opscenter-oscar/config/pe_build.yaml` file. It will determine which file in the pe_builds directory oscar searches for.

* Bring up the puppet master vm and log into it:
  ```
  vagrant up master
  vagrant ssh master
  sudo su -
  ```

* You might also want to install r10k or puppet-librarian on your host machine and install the modules the opscenter-control repo uses on your host so you can browse through them.

* Now bring up one or more agents with oscar on your host machine
  ```
  vagrant up gitlab
  ```

