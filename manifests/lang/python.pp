# Python devbox language configuration.
class devbox::lang::python(
  $dependencies,
  $packages,
  $pip_packages,
  $virtualenvsource,
  $pypi_username = '',
  $pypi_password = '',
  $default_version = '3'
) {

  include ::devbox::lang

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${devbox::home}/.config"], { ensure => directory })
  ensure_resource(file, ["${devbox::home}/.local", "${devbox::home}/.local/share", "${devbox::home}/.local/share/python", "${devbox::home}/.local/share/python/virtualenvs"], { ensure => directory })

  exec { 'retreive_pip':
    command => '/usr/bin/curl -L https://bootstrap.pypa.io/get-pip.py > /tmp/get-pip.py',
    creates => '/tmp/get-pip.py',
    require => Package[$dependencies],
  }

  exec { 'install_pip2':
    command   => '/usr/bin/python2 /tmp/get-pip.py',
    creates   => '/usr/local/bin/pip',
    require   => Package[$packages],
    subscribe => Exec['retreive_pip'],
  }
  exec { 'install_pip3':
    command   => '/usr/bin/python3 /tmp/get-pip.py',
    creates   => '/usr/local/bin/pip',
    require   => Package[$packages],
    subscribe => Exec['retreive_pip'],
  }

  file { '/usr/bin/python':
    ensure  => link,
    target  => "/usr/bin/python${default_version}",
    owner   => root,
    group   => root,
  }
  file { '/usr/bin/pip':
    ensure  => link,
    target  => "/usr/bin/pip${default_version}",
    owner   => root,
    group   => root,
  }

  ensure_packages($pip_packages, {
    ensure   => latest,
    provider => pip,
    require  => [Exec['install_pip2'], Exec['install_pip3']],
  })

  file { '/etc/pylintrc',
    ensure  => present,
    source  => 'puppet:///modules/devbox/lang/python/pylintrc',
    mode    => '0644',
  }

  file { "${devbox::home}/.config/python":
    ensure  => directory,
    require => File["${devbox::home}/.config"],
  } ->
  file { "${devbox::home}/.config/python/virtualenvs": ensure => directory } ->
  file { "${devbox::home}/.config/python/virtualenvs/hooks": ensure => directory }
  file { "${devbox::home}/.config/python/virtualenvs/hooks/postactivate":
    ensure  => file,
    content => template('lang/python/virtualenv/postactivate'),
    mode    => '0644',
    require => File["${devbox::home}/.config/python/virtualenvs/hooks"],
  }
  file { "${devbox::home}/.config/python/virtualenvs/hooks/postdeactivate":
    ensure  => file,
    content => template('lang/python/virtualenv/postdeactivate'),
    mode    => '0644',
    require => File["${devbox::home}/.config/python/virtualenvs/hooks"],
  }
  file { "${devbox::home}/.config/python/virtualenvs/hooks/postmkvirtualenv":
    ensure  => file,
    content => template('lang/python/virtualenv/postmkvirtualenv'),
    mode    => '0644',
    require => File["${devbox::home}/.config/python/virtualenvs/hooks"],
  }

  file { "${devbox::home}/.pypirc":
    ensure  => file,
    content => template('lang/python/pypirc.erb'),
    mode    => '0644',
  }

  ensure_resource(file, ["${devbox::home}/.config/terminal", "${devbox::home}/.config/terminal/extras"], { ensure => directory })
  file { "${devbox::home}/.config/terminal/extras/devbox-lang-python.sh":
    ensure  => file,
    content => template('lang/python/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

  file { '/etc/pythonstartup',
    ensure => present,
    source => 'puppet:///modules/devbox/lang/python/startup2.py',
    mode   => '0755',
  }
  file { '/etc/python3startup',
    ensure => present,
    source => 'puppet:///modules/devbox/lang/python/startup3.py',
    mode   => '0755',
  }

}
