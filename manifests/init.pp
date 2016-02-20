class subversion($packages) {

  package { $packages: ensure => latest }

}
