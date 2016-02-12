class vault ($config, $service_location, $service_template, $url) {

  ensure_packages(['curl', 'unzip'], { ensure => latest })

  File { owner => root, group => root }

  exec { 'retrieve_vault':
    command => "/usr/bin/curl -s ${::vault::url} > /tmp/vault.zip",
    creates => '/tmp/vault.zip',
    require => Package['curl'],
  } ~>
  exec { 'unzip_vault':
    command => '/usr/bin/unzip /tmp/vault.zip -d /opt',
    creates => '/opt/vault',
    require => Package['unzip'],
  } ~>
  file { '/opt/vault':
    mode   => '0755',
    notify => Service['vault'],
  }

  # TODO: split into client and server
  file { '/etc/vault.d': ensure  => directory } ->
  file { '/etc/vault.d/config.json':
    content => $::vault::config,  # TODO: hiera-ize instead of JSON
    mode    => '0644',
    notify  => Service['vault'],
  }

  file { $::vault::service_location:
    ensure  => file,
    content => template($::vault::service_template),  # TODO: check os support
    mode    => '0644',
  } ~>
  service { 'vault':
    ensure  => running,
    enable  => true,
  }

}
