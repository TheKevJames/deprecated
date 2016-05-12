# Redis devbox db configuration.
class devbox::db::redis($packages, $config) {

  include ::devbox::db
  include ::logrotate

  ensure_packages($packages, { ensure => latest })

  ensure_resource(file, ["${devbox::home}/.local", "${devbox::home}/.local/share", "${devbox::home}/.local/share/redis"], { ensure => directory })

  file { $config:
    ensure => present,
    source => 'puppet:///modules/devbox/db/redis.conf',
    mode   => '0640',
    owner  => redis,
    group  => redis,
  }

  file { "${devbox::home}/.config/terminal/extras/devbox-db-redis.sh":
    ensure  => file,
    content => template('devbox/db/redis/env.erb'),
    mode    => '0755',
    require => File["${devbox::home}/.config/terminal/extras"],
  }

  # TODO: check this on OSX (redis installed as user over redis by default?)
  group { 'redis': ensure => 'present' } ->
  user { 'redis':
    ensure => present,
    groups => 'redis',
  }

  logrotate::rule { 'redis':
    path          => '/var/log/redis/*.log',
    compress      => true,
    copytruncate  => true,
    delaycompress => true,
    ifempty       => false,
    missingok     => true,
    rotate        => 4,
    rotate_every  => 'week',
    su            => true,
    su_owner      => redis,
    su_group      => redis,
  }

}
