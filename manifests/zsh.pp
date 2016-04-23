# Install and configure zsh.
class terminal::zsh($packages) {

  include ::terminal

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${terminal::home}/.local", "${terminal::home}/.local/share", "${terminal::home}/.local/share/zsh"], { ensure => directory })

  file { "${terminal::home}/.config/zsh":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/zsh',
    require => File["${terminal::home}/.config"],
  }

  file { "${terminal::home}/.zshrc":
    ensure => link,
    target => "${terminal::home}/.config/zsh/zshrc",
  }

}
