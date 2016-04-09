class transmission::daemon($packages, $home, $password, $user) {

  if $::operatingsystem != 'Darwin' {
    include ::osbase
    include ::transmission

    ensure_packages($packages, { ensure => latest })

    file { "${home}/.config/transmission-daemon":
      ensure  => directory,
      require => File["${home}/.config"],
    } ->
    file { "${home}/.config/transmission-daemon/settings.managed.json":
      ensure  => present,
      content => template('transmission/daemon.erb'),
      mode    => '0600',
    } ~>
    exec { 'update_transmission_daemon_settings':
      command     => "pkill -f transmission-daemon; cp ${home}/.config/transmission-daemon/settings.managed.json ${home}/.config/transmission-daemon/settings.json",
      path        => ['/usr/bin', '/bin'],
      refreshonly => true,
      before      => Service['transmission-daemon'],
    }

    service { 'transmission-daemon':
      ensure => running,
      enable => true,
    }

    file { "${home}/torrent": ensure => directory } ->
    file { ["${home}/torrent/done",
            "${home}/torrent/incomplete",
            "${home}/torrent/watch"]: ensure  => directory }
  }

}
