class transmission::gui($home) {

  include ::transmission

  ensure_resource(file, "${home}/.config", { ensure => directory })

  file { "${home}/.config/transmission":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/transmission/settings.json":
    ensure  => present,
    content => template('transmission/gui.erb'),
    mode    => '0600',
  }

  if $::operatingsystem == 'Darwin' {
    file { "${home}/Library/Application Support/Transmission":
      ensure  => link,
      target  => "${home}/.config/transmission",
    }
  }

}
