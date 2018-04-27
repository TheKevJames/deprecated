# MySQL devbox db configuration.
class devbox::db::mysql($packages) {

  include ::devbox::db
  include ::logrotate

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${devbox::home}/.local", "${devbox::home}/.local/share", "${devbox::home}/.local/share/mysql"], { ensure => directory })
  ensure_resource(file, ['/var/log', '/var/log/mysql'], {
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0750',
  })

  file { "${devbox::home}/.config/terminal/extras/devbox-db-mysql.sh":
    ensure  => file,
    content => template('devbox/db/mysql/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

  ensure_resource(file, '/etc/logrotate.d/mysql-server', { ensure => absent })
  logrotate::rule { 'mysql':
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
