# `git-wtf` tool installation.
class git::utilities::wtf($dependencies, $url) {

  include ::git::utilities

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retrieve_wtf':
    command => "/usr/bin/curl -Ls ${::git::utilities::wtf::url} > /usr/local/bin/git-wtf",
    creates => '/usr/local/bin/git-wtf',
    require => Package['curl'],
  } ~>
  file { '/usr/local/bin/git-wtf':
    ensure => present,
    mode   => '0755',
  }

}
