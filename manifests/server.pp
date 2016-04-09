class mpd::server($packages, $home, $music_dir, $service_location, $service_template, $user) {

  include ::mpd
  include ::osbase

  package { $packages: ensure => latest }

  file { "${home}/.config/mpd":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/mpd/mpd.conf":
    ensure  => present,
    content => template('mpd/config.erb'),
    mode    => '0644',
    notify  => Service['mpd'],
  }

  file { ["${home}/.config/mpd/database",
          "${home}/.config/mpd/log",
          "${home}/.config/mpd/pid",
          "${home}/.config/mpd/state",
          "${home}/.config/mpd/sticker.sql"]:
    ensure  => present,
    mode    => '0644',
    require => File["${home}/.config/mpd"],
  }

  file { "${home}/.config/mpd/playlists":
    ensure  => directory,
    require => File["${home}/.config/mpd"],
  }

  file { $service_location:
    ensure  => file,
    content => template("mpd/${service_template}"),
    mode    => '0644',
    owner   => root,
    group   => root,
  } ~>
  service { 'mpd':
    ensure   => running,
    enable   => true,
  }

}
