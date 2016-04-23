# Javascript devbox language configuration.
class devbox::lang::javascript($dependencies, $packages) {

  include ::devbox::lang

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  exec { 'install_npm':
    command => '/usr/bin/curl -L http://npmjs.org/install.sh | sh',
    require => [Package[$dependencies], Package[$packages]],
  }

  if $::operatingsystem == 'Debian' and $::operatingsystemrelease == '7' {
    exec { 'install_nodejs_sources':
      command => '/usr/bin/curl -sL https://deb.nodesource.com/setup_5.x | bash -',
      creates => '/etc/apt/sources.list.d/nodesource.list',
      before  => Package[$packages],
      require => Package[$dependencies],
    }
  }

}
