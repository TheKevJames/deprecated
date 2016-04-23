# Screen devbox tool configuration.
class devbox::tool::screen($packages) {

  include ::devbox::tool

  ensure_packages($packages, { ensure => latest })

  file { '/usr/local/etc/screenrc':
    ensure  => file,
    content => template('devbox/tool/screen/config.erb'),
    mode    => '0644',
  }

}
