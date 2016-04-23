# Heroku docker tool configuration.
class devbox::tool::docker($packages) {

  include ::devbox::tool

  ensure_packages($packages, { ensure => latest })

}
