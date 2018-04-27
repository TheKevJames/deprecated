class transmission($packages) {

  ensure_packages($packages, { ensure => latest })

}
