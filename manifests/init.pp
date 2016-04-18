class irssi($dependencies, $packages, $home, $fullname, $username, $password) {

  ensure_resource(file, "${home}/.config", { ensure => directory })

  ensure_packages($dependencies, { ensure => latest })
  ensure_packages($packages, { ensure => latest })

  file { "${home}/.config/irssi":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/irssi/scripts": ensure => directory } ->
  file { "${home}/.config/irssi/scripts/autorun": ensure => directory }

  file { "${home}/.config/irssi/config":
    ensure  => file,
    content => template('irssi/config.erb'),
    mode    => '0644',
    require => File["${home}/.config/irssi"],
  }

  exec { 'adv_windowlist.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/adv_windowlist.pl > ${home}/.config/irssi/scripts/autorun/adv_windowlist.pl",
    creates => "${home}/.config/irssi/scripts/autorun/adv_windowlist.pl",
    require => [Package['curl'], File["${home}/.config/irssi/scripts/autorun"]],
  }

  exec { 'hilightwin.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/hilightwin.pl > ${home}/.config/irssi/scripts/autorun/hilightwin.pl",
    creates => "${home}/.config/irssi/scripts/autorun/hilightwin.pl",
    require => [Package['curl'], File["${home}/.config/irssi/scripts/autorun"]],
  }

  exec { 'nicklist.pl':
    command => "/usr/bin/curl -s http://wouter.coekaerts.be/irssi/scripts/nicklist.pl > ${home}/.config/irssi/scripts/autorun/nicklist.pl",
    creates => "${home}/.config/irssi/scripts/autorun/nicklist.pl",
    require => [Package['curl'], File["${home}/.config/irssi/scripts/autorun"]],
  }

  exec { 'smartfilter.pl':
    command => "/usr/bin/curl -s https://raw.githubusercontent.com/lifeforms/irssi-smartfilter/master/smartfilter.pl > ${home}/.config/irssi/scripts/autorun/smartfilter.pl",
    creates => "${home}/.config/irssi/scripts/autorun/smartfilter.pl",
    require => [Package['curl'], File["${home}/.config/irssi/scripts/autorun"]],
  }

  # irssi does not support XDG. irssi should support XDG.
  file { "${home}/.irssi":
    ensure => link,
    target => "${home}/.config/irssi",
    force  => true,
  }

}
