# Postgres devbox db configuration.
class devbox::db::postgres($packages) {

  include ::devbox::db

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${devbox::home}/.local", "${devbox::home}/.local/share", "${devbox::home}/.local/share/postgres"], { ensure => directory })

  file { "${devbox::home}/.config/postgres":
    ensure => present,
    source => 'puppet:///modules/devbox/db/postgresrc',
    mode   => '0644',
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-db-postgres.sh":
    ensure  => file,
    content => template('devbox/db/postgres/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

}
