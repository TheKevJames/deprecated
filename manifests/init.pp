class subversion {

  $packages = hiera('subversion::packages')
  package { $packages: ensure => latest }

}
