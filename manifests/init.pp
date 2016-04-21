# Configure common terminal settings.
define terminal($os, $home, $homebrew_github_api_token) {

  ensure_resource(file, "${home}/.config", { ensure => directory })
  ensure_resource(file, "${home}/.config/terminal", {
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/common',
    require => File["${home}/.config"],
  })
  ensure_resource(file, "${home}/.config/terminal/os.sh", {
    ensure  => present,
    source  => "puppet:///modules/terminal/common/os/${os}.sh",
    require => File["${home}/.config/terminal"],
  })

  ensure_resource(file, "${home}/.inputrc", {
    ensure => 'link',
    target => "${home}/.config/terminal/inputrc",
  })
  ensure_resource(file, "${home}/.profile", {
    ensure => 'link',
    target => "${home}/.config/terminal/profile",
  })

  if $::operatingsystem == 'Darwin' and $homebrew_github_api_token {
    ensure_resource(file, "${home}/.config/terminal/extras/homebrew.sh", {
      ensure  => present,
      mode    => '0755',
      content => "export HOMEBREW_GITHUB_API_TOKEN=${homebrew_github_api_token}",
      require => File["${home}/.config/terminal"],
    })
  }

}
