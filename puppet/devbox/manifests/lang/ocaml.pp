# OCaml devbox language configuration.
class devbox::lang::ocaml($dependencies, $packages) {

  include ::devbox::lang

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  exec { 'install_opam':
    command => '/usr/bin/curl -L https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh | /bin/sh -s -- /usr/local/bin',
    creates => '/usr/local/bin/opam',
    require => [Package[$dependencies], Package[$packages]],
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-ocaml.sh":
    ensure  => file,
    content => template('devbox/lang/ocaml/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
