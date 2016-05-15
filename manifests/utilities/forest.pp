# `git-forest` tool installation.
class git::utilities::forest($dependencies, $url) {

  include ::git::utilities

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retrieve_forest':
    command => "/usr/bin/curl -Ls ${::git::utilities::forest::url} > /usr/local/bin/git-forest",
    creates => '/usr/local/bin/git-forest',
    require => Package['curl'],
  } ~>
  file { '/usr/local/bin/git-forest':
    ensure => present,
    mode   => '0755',
  }

}
