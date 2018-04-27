# Install and configure consul. Run consul as service.
class consul (
  $dependencies,
  $service_location,
  $service_template,
  $url,
  $home,
  $datacenter,
  $atlas_infrastructure,
  $atlas_token,
  $server
) {

  ensure_packages($dependencies, { ensure => latest })

  File { owner => root, group => root }

  exec { 'retrieve_consul':
    command => "/usr/bin/curl -s ${url} > /tmp/consul.zip",
    creates => '/tmp/consul.zip',
    require => Package['curl'],
  } ~>
  exec { 'unzip_consul':
    command => '/usr/bin/unzip /tmp/consul.zip -d /opt',
    creates => '/opt/consul',
    require => Package['unzip'],
  } ~>
  file { '/opt/consul':
    mode   => '0755',
    notify => Service['consul'],
  }

  file { '/etc/consul.d': ensure  => directory }
  if $server {
    file { '/etc/consul.d/config.json':
      ensure  => file,
      content => template('consul/server.erb'),
      mode    => '0644',
      require => File['/etc/consul.d'],
      notify  => Service['consul'],
    }
  }

  file { $service_location:
    ensure  => file,
    content => template($service_template),
    mode    => '0644',
  } ~>
  service { 'consul':
    ensure => running,
    enable => true,
  }

}
