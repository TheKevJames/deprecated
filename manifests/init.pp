class neovim($packages, $home) {

  ensure_packages($packages, { ensure => latest })

  file { "${home}/.config/nvim": ensure => directory } ->
  file { "${home}/.config/nvim/init.vim":
    ensure => present,
    source => 'puppet://modules/neovim/init.vim',
    mode   => '0644',
  }

  if $::operatingsystem == 'Ubuntu' {
    file { '/etc/apt/sources.list.d/neovim-ppa-unstable.list'
      ensure  => file,
      content => template('neovim/ubuntu-ppa.erb'),
      before  => Package[$packages],
    }
  }

}
