class transmission::daemon($packages, $home, $password, $user) {

  if $::operatingsystem != 'Darwin' {
    include ::transmission

    ensure_packages($packages, { ensure => latest })

    file { '/var/lib/transmission':
      ensure  => directory,
      owner   => 'transmission',
      group   => 'transmission',
    } ->
    file { '/var/lib/transmission/.config':
      ensure  => directory,
      owner   => 'transmission',
      group   => 'transmission',
    } ->
    file { '/var/lib/transmission/.config/transmission':
      ensure  => directory,
      owner   => 'transmission',
      group   => 'transmission',
    } ->
    file { '/var/lib/transmission/.config/transmission/settings.managed.json':
      ensure  => present,
      content => template('transmission/daemon.erb'),
      owner   => 'transmission',
      group   => 'transmission',
      mode    => '0600',
    } ~>
    exec { 'replace-transmission-daemon-settings':
      command     => '/bin/cp /var/lib/transmission/.config/transmission/settings.managed.json /var/lib/transmission/.config/transmission/settings.json',
      require     => Exec['stop-transmission-daemon'],
      refreshonly => true,
    }

    exec { 'stop-transmission-daemon':
      command     => '/sbin/service transmission-daemon stop',
      onlyif      => '/sbin/service transmission-daemon status',
      subscribe   => File['/var/lib/transmission/.config/transmission/settings.managed.json'],
      refreshonly => true,
    } ->
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
