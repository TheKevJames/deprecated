# Configures bazaar for a user.
class bazaar::user($home, $fullname, $email) {

  include ::bazaar

  ensure_resource(file, "${home}/.config", { ensure => directory })

  file { "${home}/.config/bazaar":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/bazaar/bazaar.conf":
    ensure  => file,
    content => template('bazaar/config.erb'),
    mode    => '0644',
  }

  file { "${home}/.config/bazaar/ignore":
    ensure  => present,
    source  => 'puppet:///modules/bazaar/ignore',
    mode    => '0644',
    require => File["${home}/.config/bazaar"],
  }

}
