# Configure common terminal settings.
class terminal($os, $home, $homebrew_github_api_token = undef) {

  ensure_resource(file, ["${home}/.config", "${home}/.config/terminal", "${home}/.config/terminal/extras"], { ensure => directory })
  ensure_resource(file, "${home}/.config/terminal/prompt", {
    ensure  => present,
    recurse => true,
    source  => 'puppet:///modules/terminal/common/prompt',
    require => File["${home}/.config/terminal"],
  })
  ensure_resource(file, "${home}/.config/terminal/aliases.sh", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/aliases.sh',
    require => File["${home}/.config/terminal"],
  })
  ensure_resource(file, "${home}/.config/terminal/common.sh", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/common.sh',
    require => File["${home}/.config/terminal"],
  })
  ensure_resource(file, "${home}/.config/terminal/extras.sh", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/extras.sh',
    require => File["${home}/.config/terminal"],
  })
  ensure_resource(file, "${home}/.inputrc", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/inputrc',
  })
  ensure_resource(file, "${home}/.config/terminal/path.sh", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/path.sh',
    require => File["${home}/.config/terminal"],
  })
  ensure_resource(file, "${home}/.profile", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/profile',
  })
  ensure_resource(file, "${home}/.config/terminal/var.sh", {
    ensure  => present,
    source  => 'puppet:///modules/terminal/common/var.sh',
    require => File["${home}/.config/terminal"],
  })

  ensure_resource(file, "${home}/.config/terminal/os.sh", {
    ensure  => present,
    source  => "puppet:///modules/terminal/common/os/${os}.sh",
    require => File["${home}/.config/terminal"],
  })

  if $::operatingsystem == 'Darwin' and $homebrew_github_api_token {
    ensure_resource(file, "${home}/.config/terminal/extras/homebrew.sh", {
      ensure  => present,
      mode    => '0755',
      content => "export HOMEBREW_GITHUB_API_TOKEN=${homebrew_github_api_token}",
      require => File["${home}/.config/terminal/extras"],
    })
  }

}
