class transmission::daemon($packages, $home, $password, $user) {

  if $::operatingsystem != 'Darwin' {
    include ::transmission

    ensure_packages($packages, { ensure => latest })

    file { "${home}/.config/transmission-daemon": ensure => directory } ->
    file { "${home}/.config/transmission-daemon/settings.json":
      ensure  => present,
      content => template('transmission/daemon.erb'),
      mode    => '0600',
    }

    file { "${home}/torrent": ensure => directory } ->
    file { ["${home}/torrent/done",
            "${home}/torrent/incomplete",
            "${home}/torrent/watch"]: ensure  => directory }
  }

}
