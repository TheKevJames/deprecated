# Android devbox framework configuration.
class devbox::framework::android {

  include ::devbox::framework
  include ::devbox::lang::java

  # TODO: install android SDK

  file { "${devbox::home}/.config/terminal/extras/devbox-lang-android.sh":
    ensure  => file,
    content => template('framework/android/env.erb'),
    mode    => '0755',
    require => "${devbox::home}/.config/terminal/extras",
  }

}
