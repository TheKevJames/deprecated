# Javascript devbox language configuration.
class devbox::lang::javascript($packages) {

  include ::devbox::lang

  ensure_packages($packages, { ensure => latest })

}
