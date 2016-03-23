exec { 'create-ssh-key':
  command => 'yes y | ssh-keygen -t dsa -C "r10k" -f /root/.ssh/id_dsa -q -N ""',
  path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  creates => '/root/.ssh/id_dsa.pub',
} ->

#https://docs.puppetlabs.com/references/latest/type.html#sshkey
sshkey { 'gitlab.olindata.com':
  ensure => present,
  type   => 'ecdsa-sha2-nistp256',
  target => '/root/.ssh/known_hosts',
  key    => 'AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDw3fj8seCnMtJTnNSehf+Fl1xlCtgP3GOcwjSTZHHt7wHdip32C9PplZtNej+t1LWSmaW41JNyNxlSoYer1Kys='
} ->

# https://github.com/abrader/abrader-gms
git_deploy_key { 'add_deploy_key_to_puppet_control':
  ensure       => present,
  name         => $::fqdn,
  path         => '/root/.ssh/id_dsa.pub',
  token        => 'N3gMsG-nsB-n_6UFkbL7',
  project_name => 'opstheater/opstheater',
  server_url   => 'https://gitlab.olindata.com',
  provider     => 'gitlab',
} ->

class { 'r10k':
  version    => '2.0.3',
  configfile => '/etc/puppetlabs/r10k/r10k.yaml',
  sources    => {
    'puppet' => {
      'remote'  => 'git@gitlab.olindata.com:opstheater/opstheater.git',
      'basedir' => $::settings::environmentpath,
      'prefix'  => false,
    }
  },
}
