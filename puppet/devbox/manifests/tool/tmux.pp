# Tmux devbox tool configuration.
class devbox::tool::tmux($dependencies, $packages) {

  include ::devbox::tool

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  file { '/etc/tmux.conf':
    ensure  => file,
    content => template('devbox/tool/tmux/config.erb'),
    mode    => '0644',
  }

}
