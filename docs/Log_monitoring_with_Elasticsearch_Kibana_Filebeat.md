# Log monitoring with Elasticsearch, Kibana & Filebeat
### Elasticserach :

Let us start with understanding What is elasticsearch and why it is used for  ?
ElasticSearch is an open source, RESTful java based search engine which is used for search and index document files in diverse formats. It performs near-real-time searches.

##### Installing and configuring Elasticsearch via Puppet :

As previously discussed elasticsearch is java based, so for making elasticsearch work we need to install java also. For installing java we are using [puppetlabs/java](https://forge.puppetlabs.com/puppetlabs/java) module from puppet forge.
```sh
include ::java
```
Adding this line in the .pp class will Installs the correct Java package on various platform.

For installation and configuration of elasticsearch we have used [elasticsearch/elasticsearch](https://forge.puppetlabs.com/elasticsearch/elasticsearch) module available on puppet forge
```sh
include ::elasticsearch
```
Above line will install elasticsearch version 2.0 on the node.

Configuring elasticsearch is very straightforward with elasticsearch module, by calling a elasticsearch resource elasticsearch::instance and passing elasticsearch instance details to the resource.

Right now we are passing the following instance details to the **elasticsearch::instance** resource :
```sh
network.host
http.port
```

### Kibana :

Kibana 4 is an analytics and visualization platform that builds on Elasticsearch to give you a better understanding of your data.

##### Installing and configuring kibana via Puppet :

For installing and configuring kibana through puppet we are using lesaux-kibana4 module from puppetforge.

This module by default installs and configure Kibana 4.1.2 for you which is not compatible with elasticsearch version 2.0, so we are configuring this module to use Kibana 4.2 from its source (*as only kibana 4.2 and higher are compatible with elasticsearch 2*)

We have used class kibana4 with initializing some variables like :
```sh
class { 'kibana4':

  package_download_url  	=>
  elasticsearch_url 		=>
  host                		=> 
  port                		=>

}
```
### How to contribute code for Elasticsearch, Kibana & Filebeat :

If you want to have a look at puppetised code for Elasticsearch, Kibana & Filebeat, you can check that on this git repository : *https://github.com/olindata/opscenter-control*

And if you think this excites you, then you can also contribute in the code.
Please follow the below steps for the same :

On your development machine (local machine) clone the opscenter control repository using command : 
```sh
git clone git@github.com:olindata/opscenter-control.git
```
This will create a directory call opscenter-control on your current location.
You can contribute your code in this local directory and push it to a new branch 
```sh
checkout -b <author>/[fixes|features]/<name>
```
Now you will be on a new branch that you have just create now, to check the same run command
```sh
git branch 
```
Now once you have done with your code you will need to push it to the repository with following steps :
```sh
git add <file name>

git commit -m “ your comment about the changes getting committed ”

git push origin <branch name> 
```
**Note : here branch name will be same as what you have create in earlier step.**

This step will push your changes to the repository superwebs-puppet on the branch you created.
Now you can request Walter to check your code and merge it with the original repository.

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

