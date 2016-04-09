class transmission($packages) {

  class { '::osbase': home => $home }

  ensure_packages($packages, { ensure => latest })

}
