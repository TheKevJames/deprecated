# Ruby devbox language configuration.
class devbox::lang::ruby($packages, $gem_packages) {

  include ::devbox::lang

  ensure_packages($packages, { ensure => latest })
  # TODO: install rvm

  ensure_packages($gem_packages, {
    ensure   => latest,
    provider => gem,
    require  => Package[$packages],
  })

  file { '/etc/gemrc':
    ensure => present,
    source => 'puppet:///modules/devbox/lang/ruby/gemrc',
    mode   => '0644',
  }
  file { '/etc/irbrc':
    ensure => present,
    source => 'puppet:///modules/devbox/lang/ruby/irbrc',
    mode   => '0644',
  }

  file { "${devbox::home}/.local/share/ruby":
    ensure  => directory,
    require => "${devbox::home}/.local/share",
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-ruby.sh":
    ensure  => file,
    content => template('lang/ruby/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

}
