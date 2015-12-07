# Log monitoring with Elasticsearch, Kibana & Filebeat
## Elasticserach :

Let us start with understanding What is elasticsearch and why it is used for  ?
ElasticSearch is an open source, RESTful java based search engine which is used for search and index document files in diverse formats. It performs near-real-time searches.

### Installing and configuring Elasticsearch via Puppet :

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

## Kibana :

Kibana 4 is an analytics and visualization platform that builds on Elasticsearch to give you a better understanding of your data.

### Installing and configuring kibana via Puppet :

For installing and configuring kibana through puppet we are using lesaux-kibana4 module from puppetforge.

This module by default installs and configure Kibana 4.1.2 for you which is not compatible with elasticsearch version 2.0, so we are configuring this module to use Kibana 4.2 from its source (*as only kibana 4.2 and higher are compatible with elasticsearch 2*)

We have used class kibana4 with initializing some variables like :
```sh
class { 'kibana4':

  package_download_url          =>
  elasticsearch_url             =>
  host                          =>
  port                          =>

}
```
