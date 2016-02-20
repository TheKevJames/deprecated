class subversion::user($home) {

  include ::subversion

  file { "${home}/.subversion": ensure => directory } ->
  file { "${home}/.subversion/config":
    ensure  => file,
    content => template('subversion/config.erb'),
    mode    => '0644',
  }

  file { "${home}/.subversion/servers":
    ensure  => present,
    source  => 'puppet:///modules/subversion/servers',
    mode    => '0644',
    require => File["${home}/.subversion"],
  }

}
