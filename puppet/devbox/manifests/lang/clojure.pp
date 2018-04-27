# Clojure devbox language configuration.
class devbox::lang::clojure($dependencies) {

  include ::devbox::lang
  include ::devbox::lang::java

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retrieve_leiningen':
    command => '/usr/bin/curl -s https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /opt/lein',
    creates => '/opt/lein',
    require => Package[$dependencies],
  } ~>
  file { '/opt/lein':
    owner => root,
    group => root,
    mode  => '0755',
  } ->
  file { '/usr/local/bin/lein':
    ensure => link,
    target => '/opt/lein',
  }

}
