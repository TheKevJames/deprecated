class git::user($home, $fullname, $email) {

  include ::git

  file { "${home}/.gitconfig":
    ensure  => file,
    content => template('git/config.erb'),
    mode    => '0644',
  }

  file { "${home}/.git.d": ensure => directory } ->
  file { "${home}/.git.d/templates": ensure => directory } ->
  file { "${home}/.git.d/templates/hooks":  ensure => directory }

  file { "${home}/.git.d/attributes":
    ensure  => present,
    source  => 'puppet:///modules/git/attributes',
    mode    => '0644',
    require => File["${home}/.git.d"],
  }

  file { "${home}/.git.d/ignore":
    ensure  => present,
    source  => 'puppet:///modules/git/ignore',
    mode    => '0644',
    require => File["${home}/.git.d"],
  }

  file { "${home}/.git.d/templates/hooks/post-commit":
    ensure  => present,
    source  => 'puppet:///modules/git/postcommit',
    mode    => '0755',
    require => File["${home}/.git.d/templates/hooks"],
  }

  file { "${home}/.git.d/templates/hooks/pre-commit":
    ensure  => present,
    source  => 'puppet:///modules/git/precommit',
    mode    => '0755',
    require => File["${home}/.git.d/templates/hooks"],
  }

}
