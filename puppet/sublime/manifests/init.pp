# Install and configure sublime.
class sublime(
  $binary_file,
  $dependencies,
  $download_url,
  $keymap_name,
  $package_file,
  $user_font_dir,
  $font_dir = undef,
  $home,
  $plugins = []
) {

  ensure_packages($dependencies, { ensure => latest })

  ensure_resource(file, "${home}/.config", { ensure => directory })
  if $font_dir != undef {
    ensure_resource(file, "${home}/${user_font_dir}", {
      ensure => link,
      target => $font_dir,
      force  => true,
    })
  }

  exec { 'retrieve_sublime':
    command => "/usr/bin/curl ${download_url} > /tmp/${package_file}",
    creates => "/tmp/${package_file}",
    require => Package[$dependencies],
  }

  case $::operatingsystem {
    'Darwin': {
      package { 'sublime':
        ensure    => present,
        provider  => pkgdmg,
        source    => "/tmp/${package_file}",
        subscribe => Exec['retrieve_sublime'],
        notify    => File['/usr/bin/sublime'],
      }

      file { "${home}/Library/Application Support/Sublime Text 3":
        ensure => link,
        target => "${home}/.config/sublime-text-3",
      }
    }
    default: {
      exec { 'untar_sublime':
        command   => "/bin/tar vxjf /tmp/${package_file} -C /opt",
        creates   => '/opt/sublime_text_3',
        subscribe => Exec['retrieve_sublime'],
        notify    => File['/usr/bin/sublime'],
      }
    }
  }

  file { '/usr/bin/sublime':
    ensure => link,
    target => $binary_file,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { "${home}/.config/sublime-text-3":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/sublime-text-3/Packages": ensure => directory } ->
  file { "${home}/.config/sublime-text-3/Packages/User": ensure => directory } ->
  file { "${home}/.config/sublime-text-3/Packages/User/Preferences.sublime-settings":
    ensure => present,
    source => "puppet:///modules/sublime/${::kernel}/config",
    mode   => '0644',
  }

  file { "${home}/.config/sublime-text-3/Packages/User/Default (${keymap_name}).sublime-keymap":
    ensure  => present,
    source  => "puppet:///modules/sublime/${::kernel}/keymap",
    mode    => '0644',
    require => File["${home}/.config/sublime-text-3/Packages/User"],
  }

  file { "${home}/.config/sublime-text-3/Packages/User/Package Control.sublime-settings":
    ensure  => present,
    content => template('sublime/package_control.erb'),
    mode    => '0644',
    require => File["${home}/.config/sublime-text-3/Packages/User"],
  }

  if member($plugins, 'BracketHighlighter') {
    file { "${home}/.config/sublime-text-3/Packages/User/bh_core.sublime-settings":
      ensure  => present,
      source  => 'puppet:///modules/sublime/brackethighlighter',
      mode    => '0644',
      require => File["${home}/.config/sublime-text-3/Packages/User"],
    }
  }

  # Included by default
  # if member($plugins, 'SideBarEnhancements') {
    file { "${home}/.config/sublime-text-3/Packages/User/Side Bar.sublime-settings":
      ensure  => present,
      source  => 'puppet:///modules/sublime/sidebar',
      mode    => '0644',
      require => File["${home}/.config/sublime-text-3/Packages/User"],
    }
  # }

  if member($plugins, 'SublimeLinter') {
    file { "${home}/.config/sublime-text-3/Packages/User/SublimeLinter.sublime-settings":
      ensure  => present,
      source  => 'puppet:///modules/sublime/lint',
      mode    => '0644',
      require => File["${home}/.config/sublime-text-3/Packages/User"],
    }
  }

}
