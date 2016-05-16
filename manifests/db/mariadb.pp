# MariaDB devbox db configuration.
class devbox::db::mariadb($packages) {

  include ::devbox::db
  include ::logrotate

  case $::operatingsystem {
    'Debian': {
      file { '/etc/apt/sources.list.d/mariadb-ppa-stable.list':
        ensure  => file,
        content => template('devbox/db/mariadb/debian-ppa.erb'),
        mode    => '0644',
      } ~>
      exec { 'refresh_apt_get_mariadb_ppa':
        command     => '/usr/bin/apt-get update',
        refreshonly => true,
      }

      ensure_packages($packages, {
        ensure  => latest,
        require => Exec['refresh_apt_get_mariadb_ppa']
      })
    }
    default: {
      ensure_packages($packages, { ensure => latest })
    }
  }

  ensure_resource(file, '/var/log', {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0750',
  })
  ensure_resource(file, '/var/log/mysql', {
    ensure  => directory,
    owner   => mysql,
    group   => mysql,
    mode    => '0750',
    require => File['/var/log'],
  })

  ensure_resource(file, '/etc/logrotate.d/mysql-server', { ensure => absent })
  logrotate::rule { 'mariadb':
    path         => '/var/log/mysql/*.log',
    compress     => true,
    ifempty      => false,
    missingok    => true,
    rotate       => 3,
    rotate_every => 'day',
    su           => true,
    su_owner     => mysql,
    su_group     => mysql,
    postrotate   => 'if test -x /usr/bin/mysqladmin && /usr/bin/mysqladmin ping &>/dev/null; then /usr/bin/mysqladmin flush-logs; fi',
  }

}
