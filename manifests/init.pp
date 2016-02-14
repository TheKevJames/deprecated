class irssi($home, $fullname, $username, $password) {

  ensure_packages(['curl', 'irssi'], { ensure => latest })

  file { "${home}/.irssi": ensure => directory } ->
  file { "${home}/.irssi/autorun": ensure => directory }

  file { "${home}/.irssi/config":
    ensure  => file,
    content => template('irssi/config.erb'),
    mode    => '0644',
    require => File["${home}/.irssi"],
  }

  exec { 'adv_windowlist.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/adv_windowlist.pl > ${home}/.irssi/autorun/adv_windowlist.pl",
    creates => "${home}/.irssi/autorun/adv_windowlist.pl",
    require => [Package['curl'], File["${home}/.irssi/autorun"]],
  }

  exec { 'hilightwin.pl':
    command => "/usr/bin/curl -s https://scripts.irssi.org/scripts/hilightwin.pl > ${home}/.irssi/autorun/hilightwin.pl",
    creates => "${home}/.irssi/autorun/hilightwin.pl",
    require => [Package['curl'], File["${home}/.irssi/autorun"]],
  }

  exec { 'nicklist.pl':
    command => "/usr/bin/curl -s http://wouter.coekaerts.be/irssi/scripts/nicklist.pl > ${home}/.irssi/autorun/nicklist.pl",
    creates => "${home}/.irssi/autorun/nicklist.pl",
    require => [Package['curl'], File["${home}/.irssi/autorun"]],
  }

  exec { 'smartfilter.pl':
    command => "/usr/bin/curl -s https://raw.githubusercontent.com/lifeforms/irssi-smartfilter/master/smartfilter.pl > ${home}/.irssi/autorun/smartfilter.pl",
    creates => "${home}/.irssi/autorun/smartfilter.pl",
    require => [Package['curl'], File["${home}/.irssi/autorun"]],
  }

}
