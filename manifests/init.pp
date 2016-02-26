class neovim($dependencies, $packages, $home) {

  file { "${home}/.config/nvim": ensure => directory } ->
  file { "${home}/.config/nvim/init.vim":
    ensure => present,
    source => 'puppet:///modules/neovim/init.vim',
    mode   => '0644',
  }

  case $::operatingsystem {
    'OpenSuSE': {
      ensure_packages($dependencies, { ensure => latest }) ->
      vcsrepo { '/tmp/neovim':
        ensure   => present,
        source   => 'https://github.com/neovim/neovim.git',
        provider => git,
        force    => false,
      } ~>
      exec { 'make_neovim':
        cwd     => '/tmp/neovim',
        command => '/usr/bin/make -C /tmp/neovim',
        creates => '/tmp/neovim/build/bin/nvim',
      } ~>
      exec { 'make_install_neovim':
        cwd     => '/tmp/neovim',
        command => '/usr/bin/make -C /tmp/neovim install',
        creates => '/usr/local/bin/nvim',
      } ->
      file { '/usr/bin/nvim':
        ensure => link,
        target => '/usr/local/bin/nvim',
      }
    }
    'Ubuntu': {
      file { '/etc/apt/sources.list.d/neovim-ppa-unstable.list':
        ensure  => file,
        content => template('neovim/ubuntu-ppa.erb'),
      } ~>
      exec { 'refresh_apt_get_neovim_ppa':
        command     => '/usr/bin/apt-get update',
        refreshonly => true,
      } ->
      ensure_packages($packages, { ensure => latest })
    }
    default: {
      ensure_packages($packages, { ensure => latest })
    }
  }

}
