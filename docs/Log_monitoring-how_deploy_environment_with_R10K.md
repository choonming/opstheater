#### Deploying your environment with R10K :

R10K is a hybrid solution for deploying Puppet code. It implements the original git workflow for deploying Puppet environments based on Git branches.

You can install r10k directly with command
```sh
gem install r10k
```
Now go to path **/etc/puppetlabs/r10k** and create file **r10k.yaml** with content as :
```sh
:cachedir: '/var/cache/r10k'
:sources:
  :local:
    remote: 'git@github.com:olindata/opscenter-control.git'
    basedir: '/etc/puppetlabs/code/environments'
```
**Note: the value of basedir should be same as environmentpath in puppet.conf**

Now you can deploy your whole environment using r10k using following command :
```sh
r10k deploy environment <environment name>
```
Here environment of your branch in the repository will act as environment name.
So when when you will run r10k deploy with your branch name as environment name it will create an environment with your branch name in your local system on path **/etc/puppetlabs/code/environments**.
