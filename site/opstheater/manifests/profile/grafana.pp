class opstheater::profile::grafana {
  $grafanauser              = hiera('opstheater::grafana::grafanauser')
  $grafanapasswd            = hiera('opstheater::grafana::grafanapasswd')
  $grafanaurl               = hiera('opstheater::grafana::url')
  $elasticsearchurl         = hiera('opstheater::elasticsearch::fqdn')
  $install_method           = hiera('opstheater::profile::grafana::install_method')
  $domain                   = hiera('opstheater::domain')
  $smtp_address             = hiera('opstheater::smtp::fqdn'),
  $smtp_port                = hiera('opstheater::smtp::port'),
  $smtp_user_name           = hiera('opstheater::smtp::username'),
  $smtp_password            = hiera('opstheater::smtp::password'),
  $smtp_openssl_verify_mode = hiera('opstheater::smtp::openssl_verify_mode'),

  class { '::grafana':
    install_method => $install_method,
    cfg            => {
      server => {
        http_port => 80,
      },
      smtp   => {
        enabled      => true,
        from_address => "grafana@${domain}",
        host         => "${smtp_address}:${smtp_port}",
        user         => $smtp_user_name,
        password     => $smtp_password,
        skip_verify  => $smtp_openssl_verify_mode,
      }
    }
  }

  # curl http://admin:admin@localhost:3000/api/datasources -X POST -H 'Content-Type: application/json;charset=UTF-8' \
  # --data '{"Name":"OpsTheater7","type":"elasticsearch","url":"http://elasticsearch.opstheater.vm:9200","access":"proxy","isDefault":true,"database":"[logstash-]YYYY.MM.DD","jsonData":{"timeField":"@timestamp", "esVersion": 2, "interval":"Daily"}}'

  grafana_datasource { 'elastic':
    grafana_url      => "http://${grafanaurl}:3000",
    grafana_user     => $grafanauser,
    grafana_password => $grafanapasswd,
    url              => "http://${elasticsearchurl}:9200",
    type             => elasticsearch,
    access_mode      => proxy,
    is_default       => true,
    database         => '[logstash-]YYYY.MM.DD',
    json_data        => {
      timeField => '@timestamp',
      esVersion => '2',
      interval  => 'Daily',
    },
  }

}
