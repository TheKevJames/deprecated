# C devbox language configuration.
class devbox::lang::c($dependencies, $packages) {

  include ::devbox::lang

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  exec { 'retrieve_c':
    command => '/usr/bin/curl -s https://raw.githubusercontent.com/ryanmjacobs/c/master/c > /usr/bin/c',
    creates => '/usr/bin/c',
    require => Package[$dependencies],
  } ~>
  file { '/usr/bin/c': mode => '0755' }

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-c.sh":
    ensure  => file,
    content => template('lang/c/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

}
