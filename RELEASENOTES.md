# Release notes

## Release 1.4 (March 2nd 2016)

Since this is our first release, basically all functionality is new. However we have worked on the following features in the cycle since the first internal beta release. In OpsTheater 1.4 we have added the following new features:

* automatically send the following logs to elasticsearch:
** Gitlab
** Puppetmaster / puppet agents
** The foreman
** Icinga master / Client
** Elasticsearch / Kibana / Logstash
** Mattermost
** MySQL
* HTTPS for all relevant services. This means for a full OpsTheater deployment you need a wildcard cert as a self-generated cert causes problems with several of the services we use
* Added a reverse proxy for terminating SSL requests for the foreman
* Split off the icinga database to the mysql server, allowing for better scaling and separation between app and database
* Refactored a large swath of code so we can start having an opstheater puppet module that just needs to have configuration data fed to it
* Added initial basic checks for all icinga monitored hosts


In addition to this, we have updated the components in use by OpsTheater to the following versions, each of which comes with it's own release notes:

| Tool | Version | Release notes |
|--- | --- | --- | 
| Foreman | 1.10.2 | [Release notes](http://theforeman.org/manuals/1.10/index.html#Releasenotesfor1.10.2) |
| FOSS Puppet | 4.3.2 | [Release notes](https://docs.puppetlabs.com/puppet/4.3/reference/release_notes.html#puppet-432) |
| Percona Server | 5.6.28 | [Release notes](https://www.percona.com/doc/percona-server/5.6/release-notes/Percona-Server-5.6.28-76.1.html#module-5.6.28-76.1) |
| Icinga Web 2 | 2.1.2 | [Release notes](https://github.com/Icinga/icingaweb2/blob/master/ChangeLog) |
| Icinga 2 | 2.4.3 | [Release notes](http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/about-icinga2#whats-new) |
| Gitlab | 8.5 | [Release notes](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/CHANGELOG) |
| Mattermost | 2.0 | [Release notes](https://github.com/mattermost/platform/releases/tag/v2.0.0) |
| ElasticSearch | 2.2 | [Release notes](https://www.elastic.co/guide/en/elasticsearch/reference/current/release-notes-2.2.0.html) |
| Logstash | 2.1.1 | [Release notes](https://github.com/elastic/logstash/blob/2.1/CHANGELOG.md) |
| Kibana | 4.2.1 | [Release notes](https://www.elastic.co/guide/en/kibana/4.2/releasenotes.html) |
