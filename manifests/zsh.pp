# Install and configure zsh.
class terminal::zsh($os, $packages, $home, $homebrew_github_api_token = undef) {

  terminal { 'zshterm':
    os                        => $os,
    home                      => $home,
    homebrew_github_api_token => $homebrew_github_api_token,
  }

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${home}/.local", "${home}/.local/share", "${home}/.local/share/zsh"], { ensure => directory })

  file { "${home}/.config/zsh":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/zsh',
    require => File["${home}/.config"],
  }

  file { "${home}/.zshrc":
    ensure => link,
    target => "${home}/.config/terminal/bash/zshrc",
  }

}
