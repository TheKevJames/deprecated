# Configure common terminal utilities.
class terminal::utilities($packages) {

  include ::terminal

  ensure_packages($packages, { ensure => latest })

  file { "${terminal::home}/.config/terminal/extras/less.sh":
    ensure  => present,
    mode    => '0755',
    content => "export PAGER=`which less`\nexport LESSHISTFILE=/dev/null",
    require => File["${terminal::home}/.config/terminal/extras"],
  }

}
