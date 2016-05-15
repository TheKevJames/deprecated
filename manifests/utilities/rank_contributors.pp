class git::utilities::rank_contributors($dependencies, $url) {

  include ::git::utilities

  ensure_packages($dependencies, { ensure => latest })

  exec { 'retrieve_rank_contributors':
    command => "/usr/bin/curl -Ls ${::git::utilities::rank_contributors::url} > /usr/local/bin/git-rank-contributors",
    creates => '/usr/local/bin/git-rank-contributors',
    require => Package['curl'],
  } ~>
  file { '/usr/local/bin/git-rank-contributors':
    ensure => present,
    mode   => '0755',
  }

}
