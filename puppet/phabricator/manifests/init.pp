# Install and configure phabricator.
class phabricator($dependencies) {

  require ::git

  ensure_packages($dependencies, { ensure => latest })

  vcsrepo { '/opt/arcanist':
    ensure   => present,
    source   => 'https://github.com/phacility/arcanist.git',
    revision => master,
    provider => git,
    force    => false,
  }

  vcsrepo { '/opt/libphutil':
    ensure   => present,
    source   => 'https://github.com/phacility/libphutil.git',
    revision => master,
    provider => git,
    force    => false,
  }

  vcsrepo { '/opt/phabricator':
    ensure   => present,
    source   => 'https://github.com/phacility/phabricator.git',
    revision => master,
    provider => git,
    force    => false,
  }

}
