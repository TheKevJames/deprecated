# Configure common terminal utilities.
class terminal::utilities($os, $packages, $home, $homebrew_github_api_token = undef) {

  terminal { 'utilterm':
    os                        => $os,
    home                      => $home,
    homebrew_github_api_token => $homebrew_github_api_token,
  }

  ensure_packages($packages, { ensure => latest })

  file { "${home}/.config/terminal/extras/less.sh":
    ensure  => present,
    mode    => '0755',
    content => "export PAGER=`which less`\nexport LESSHISTFILE=/dev/null",
    require => File["${home}/.config/terminal"],
  }

}
