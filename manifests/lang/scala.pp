# Scala devbox language configuration.
class devbox::lang::scala {

  include ::devbox::lang
  include ::devbox::lang::java

  # TODO: install scala

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-scala.sh":
    ensure  => file,
    content => template('lang/scala/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

}
