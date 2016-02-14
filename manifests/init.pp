class irssi($home, $fullname, $username, $password) {

  ensure_packages(['curl', 'irssi'], { ensure => latest })

  file { "${home}/.irssi": ensure => directory } ->
  file { "${home}/.irssi/scripts": ensure => directory } ->
  file { "${home}/.irssi/scripts/autorun": ensure => directory }

  file { "${home}/.irssi/config":
    ensure  => file,
    content => template('irssi/config.erb'),
    mode    => '0644',
    require => File["${home}/.irssi"],
  }

  exec { 'adv_windowlist.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/adv_windowlist.pl > ${home}/.irssi/scripts/autorun/adv_windowlist.pl",
    creates => "${home}/.irssi/scripts/autorun/adv_windowlist.pl",
    require => [Package['curl'], File["${home}/.irssi/scripts/autorun"]],
  }

  exec { 'hilightwin.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/hilightwin.pl > ${home}/.irssi/scripts/autorun/hilightwin.pl",
    creates => "${home}/.irssi/scripts/autorun/hilightwin.pl",
    require => [Package['curl'], File["${home}/.irssi/scripts/autorun"]],
  }

  exec { 'nicklist.pl':
    command => "/usr/bin/curl -s http://wouter.coekaerts.be/irssi/scripts/nicklist.pl > ${home}/.irssi/scripts/autorun/nicklist.pl",
    creates => "${home}/.irssi/scripts/autorun/nicklist.pl",
    require => [Package['curl'], File["${home}/.irssi/scripts/autorun"]],
  }

  exec { 'smartfilter.pl':
    command => "/usr/bin/curl -s https://raw.githubusercontent.com/lifeforms/irssi-smartfilter/master/smartfilter.pl > ${home}/.irssi/scripts/autorun/smartfilter.pl",
    creates => "${home}/.irssi/scripts/autorun/smartfilter.pl",
    require => [Package['curl'], File["${home}/.irssi/scripts/autorun"]],
  }

}
