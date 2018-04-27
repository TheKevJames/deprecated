# PHP devbox language configuration.
class devbox::lang::php($packages) {

  include ::devbox::lang

  ensure_packages($packages, { ensure => latest })

}
