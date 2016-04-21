class terminal::zsh($packages, $home) {

  include ::terminal

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ['${home}/.local',
                         '${home}/.local/share',
                         '${home}/.local/share/zsh'], { ensure => directory })

  file { "${home}/.config/zsh":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/zsh',
    require => File["${home}/.config"],
  }

  file { "${home}/.zshrc":
    ensure => link,
    target => "${home}/.config/terminal/zshrc",
  }

}
