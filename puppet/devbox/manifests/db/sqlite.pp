# Sqlite devbox db configuration.
class devbox::db::sqlite($packages) {

  include ::devbox::db

  ensure_packages($packages, { ensure => latest })

  file { "${devbox::home}/.config/sqlite":
    ensure  => directory,
    require => File["${devbox::home}/.config"],
  } ->
  file { "${devbox::home}/.config/sqlite/.sqliterc":
    ensure => present,
    source => 'puppet:///modules/devbox/db/sqliterc',
    mode   => '0644',
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-db-sqlite.sh":
    ensure  => file,
    content => template('devbox/db/sqlite/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
