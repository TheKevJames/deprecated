# Install and configure bash.
class terminal::bash($os, $packages, $home, $homebrew_github_api_token = undef) {

  terminal { 'bashterm':
    os                        => $os,
    home                      => $home,
    homebrew_github_api_token => $homebrew_github_api_token,
  }

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${home}/.local", "${home}/.local/share", "${home}/.local/share/bash"], { ensure => directory })

  file { "${home}/.config/bash":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/bash',
    require => File["${home}/.config"],
  }

  file { "${home}/.bashrc":
    ensure => link,
    target => "${home}/.config/bash/bashrc",
  }

}
