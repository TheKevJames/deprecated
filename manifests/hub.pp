class git::hub($url) {

  include ::git

  ensure_packages(['curl'], { ensure => latest })

  file { '/opt/hub': ensure => directory }

  exec { 'retrieve_hub':
    command => "/usr/bin/curl -Ls ${::git::hub::url} > /tmp/hub.tgz",
    creates => '/tmp/hub.tgz',
    require => Package['curl'],
  } ~>
  exec { 'unzip_hub':
    command => "${::git::tar} -xzf /tmp/hub.tgz -C /opt/hub --strip-components 1",
    creates => '/opt/hub/bin/hub',
    require => File['/opt/hub'],
  } ->
  file { '/usr/local/bin/hub':
    ensure => link,
    target => '/opt/hub/bin/hub',
  }

}
