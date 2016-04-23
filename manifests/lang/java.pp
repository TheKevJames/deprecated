# Java devbox language configuration.
class devbox::lang::java($packages) {

  include ::devbox::lang

  ensure_packages($packages, { ensure => latest })

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-java.sh":
    ensure  => file,
    content => template('devbox/lang/java/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
