# Perl devbox language configuration.
class devbox::lang::perl {

  include ::devbox::lang

  # TODO: install perl

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-perl.sh":
    ensure  => file,
    content => template('devbox/lang/perl/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
