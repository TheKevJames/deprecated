# Golang devbox language configuration.
class devbox::lang::go($packages) {

  include ::devbox::lang

  ensure_packages($packages, { ensure => latest })

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-go.sh":
    ensure  => file,
    content => template('lang/go/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

}
