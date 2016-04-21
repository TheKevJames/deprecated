# Set up subversion config directory for a given user.
class subversion::user($home) {

  include ::subversion

  ensure_resource(file, "${home}/.config", { ensure => directory })

  file { "${home}/.config/subversion":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/subversion/config":
    ensure  => file,
    content => template('subversion/config.erb'),
    mode    => '0644',
  }

  file { "${home}/.config/subversion/servers":
    ensure  => present,
    source  => 'puppet:///modules/subversion/servers',
    mode    => '0644',
    require => File["${home}/.config/subversion"],
  }

  # subversion does not support XDG. subversion should support XDG.
  # TODO:
  #     svn --config-dir "$XDG_CONFIG_HOME"/subversion
  #     export SUBVERSION_HOME=$XDG_CONFIG_HOME/subversion
  file { "${home}/.subversion":
    ensure => link,
    target => "${home}/.config/subversion",
  }

}
