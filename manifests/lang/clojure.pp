# Clojure devbox language configuration.
class devbox::lang::clojure($dependencies) {

  include ::devbox::lang
  include ::devbox::lang::java

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retrieve_leiningen':
    command => '/usr/bin/curl -s https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/bin/lein',
    creates => '/usr/bin/lein',
    require => Package[$dependencies],
  } ~>
  file { '/usr/bin/lein':
    owner => root,
    group => root,
    mode => '0755',
  }

}
