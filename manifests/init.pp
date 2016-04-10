# Install and configure jasper.
class jasper(
  $home, $email_address, $email_password, $first_name, $last_name, $phone,
  $carrier, $location, $timezone
) {

  require ::jasper::cmuclmtk
  require ::jasper::pocketsphinx
  require ::git
  # TODO: require python2 + pip

  class { '::osbase': home => $home }

  vcsrepo { '/opt/jasper':
    ensure   => present,
    source   => 'https://github.com/jasperproject/jasper-client.git',
    revision => master,
    provider => git,
    force    => true,
  } ~>
  exec { 'jasper_requirements':
    command     => '/usr/bin/pip install -r /opt/jasper/client/requirements.txt',
    refreshonly => true,
  }

  file { "${home}/.config/jasper":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/jasper/profile.yml":
    ensure  => file,
    content => template('jasper/profile.erb'),
    mode    => '0644',
  }

  # TODO: set JASPER_HOME to XDG directory
  file { "${home}/.jasper":
    ensure => link,
    target => File["${home}/.config/jasper"],
  }

}
