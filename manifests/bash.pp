# Install and configure bash.
class terminal::bash($packages) {

  include ::terminal

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${terminal::home}/.local", "${terminal::home}/.local/share", "${terminal::home}/.local/share/bash"], { ensure => directory })

  file { "${terminal::home}/.config/bash":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/bash',
    require => File["${terminal::home}/.config"],
  }

  file { "${terminal::home}/.bashrc":
    ensure => link,
    target => "${terminal::home}/.config/bash/bashrc",
  }

}
