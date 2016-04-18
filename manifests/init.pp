# Install and configure neovim.
class neovim($dependencies, $packages, $home) {

  ensure_resource(file, "${home}/.config", { ensure => directory })

  file { "${home}/.config/nvim":
    ensure  => directory,
    require => File["${home}/.config"],
  } ->
  file { "${home}/.config/nvim/ftdetect": ensure => directory }

  file { "${home}/.config/nvim/init.vim":
    ensure  => present,
    source  => 'puppet:///modules/neovim/init.vim',
    mode    => '0644',
    require => File["${home}/.config/nvim"],
  }

  file { "${home}/.config/nvim/ftdetect/javascript.vim":
    ensure  => present,
    source  => 'puppet:///modules/neovim/javascript.vim',
    mode    => '0644',
    require => File["${home}/.config/nvim/ftdetect"],
  }
  file { "${home}/.config/nvim/ftdetect/markdown.vim":
    ensure  => present,
    source  => 'puppet:///modules/neovim/markdown.vim',
    mode    => '0644',
    require => File["${home}/.config/nvim/ftdetect"],
  }
  file { "${home}/.config/nvim/ftdetect/ruby.vim":
    ensure  => present,
    source  => 'puppet:///modules/neovim/ruby.vim',
    mode    => '0644',
    require => File["${home}/.config/nvim/ftdetect"],
  }

  case $::operatingsystem {
    'OpenSuSE': {
      ensure_packages($dependencies, { ensure => latest })

      vcsrepo { '/tmp/neovim':
        ensure   => present,
        source   => 'https://github.com/neovim/neovim.git',
        provider => git,
        force    => false,
        require  => Package[$dependencies],
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
      }

      ensure_packages($packages, {
        ensure  => latest,
        require => Exec['refresh_apt_get_neovim_ppa'],
      })
    }
    default: {
      ensure_packages($packages, { ensure => latest })
    }
  }

}
