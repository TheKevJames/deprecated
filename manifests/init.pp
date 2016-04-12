class consul (
  $service_location,
  $service_template,
  $url,
  $home,
  $datacenter,
  $infrastructure,
  $server
) {

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

  file { '/etc/consul.d': ensure  => directory } ->
  file { '/etc/consul.d/config.json':
    ensure  => file,
    content => template('consul/server.erb'),
    mode    => '0644',
    notify  => Service['consul'],
  }

  file { $service_location:
    ensure  => file,
    content => template($service_template),
    mode    => '0644',
  } ~>
  service { 'consul':
    ensure  => running,
    enable  => true,
  }

}
