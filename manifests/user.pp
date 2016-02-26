class git::user($home, $fullname, $email) {

  include ::git

  file { "${home}/.config/git": ensure => directory } ->
  file { "${home}/.config/git/templates": ensure => directory } ->
  file { "${home}/.config/git/templates/hooks":  ensure => directory }

  file { "${home}/.config/git/config":
    ensure  => file,
    content => template('git/config.erb'),
    mode    => '0644',
    require => File["${home}/.config/git"],
  }

  file { "${home}/.config/git/attributes":
    ensure  => present,
    source  => 'puppet:///modules/git/attributes',
    mode    => '0644',
    require => File["${home}/.config/git"],
  }

  file { "${home}/.config/git/ignore":
    ensure  => present,
    source  => 'puppet:///modules/git/ignore',
    mode    => '0644',
    require => File["${home}/.config/git"],
  }

  file { "${home}/.config/git/templates/hooks/post-commit":
    ensure  => present,
    source  => 'puppet:///modules/git/postcommit',
    mode    => '0755',
    require => File["${home}/.config/git/templates/hooks"],
  }

  file { "${home}/.config/git/templates/hooks/pre-commit":
    ensure  => present,
    source  => 'puppet:///modules/git/precommit',
    mode    => '0755',
    require => File["${home}/.config/git/templates/hooks"],
  }

}
