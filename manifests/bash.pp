class terminal::bash($packages, $home) {

  include ::terminal

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ['${home}/.local',
                         '${home}/.local/share',
                         '${home}/.local/share/bash'], { ensure => directory })

  file { "${home}/.config/bash":
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/bash',
    require => File["${home}/.config"],
  }

  file { "${home}/.bashrc":
    ensure => link,
    target => "${home}/.config/terminal/bashrc",
  }

}
