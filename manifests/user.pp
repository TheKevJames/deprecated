class bazaar::user($home, $fullname, $email) {

  include ::bazaar

  file { "${home}/.bazaar": ensure => directory } ->
  file { "${home}/.bazaar/bazaar.conf":
    ensure  => file,
    content => template('bazaar/config.erb'),
    mode    => '0644',
  }

  file { "${home}/.bazaar/ignore":
    ensure  => present,
    source  => 'puppet:///modules/bazaar/ignore',
    mode    => '0644',
    require => File["${home}/.bazaar"],
  }

}
