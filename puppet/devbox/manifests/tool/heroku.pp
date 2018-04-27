# Heroku devbox tool configuration.
class devbox::tool::heroku($dependencies) {

  include ::devbox::tool

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retreive_heroku_toolbelt':
    command => '/usr/bin/curl https://toolbelt.heroku.com/install.sh | sh',
    creates => '/usr/local/heroku/bin/heroku',
    require => Package[$dependencies],
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-tool-heroku.sh":
    ensure  => file,
    content => template('devbox/tool/heroku/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
