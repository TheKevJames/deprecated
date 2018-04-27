# Install and configure pocketsphinx.
class jasper::pocketsphinx($dependencies) {

  ensure_packages($dependencies, { ensure => present })

  exec { 'retrieve_sphinxbase_tarball':
    command => '/usr/bin/curl http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz > /tmp/sphinxbase.tar.gz',
    creates => '/tmp/sphinxbase.tar.gz',
    require => Package[$dependencies],
  } ~>
  exec { 'untar_sphinxbase':
    command => '/bin/tar xzf /tmp/sphinxbase.tar.gz -C /tmp',
    creates => '/tmp/sphinxbase-0.8',
  } ~>
  exec { 'configure_sphinxbase':
    cwd     => '/tmp/sphinxbase-0.8',
    command => '/bin/bash /tmp/sphinxbase-0.8/configure --enable-fixed',
    creates => '/tmp/sphinxbase-0.8/Makefile',
  } ~>
  exec { 'make_sphinxbase':
    command => '/usr/bin/make -C /tmp/sphinxbase-0.8',
    creates => '/tmp/sphinxbase-0.8/python/build',
  } ~>
  exec { 'make_install_sphinxbase':
    command => '/usr/bin/make -C /tmp/sphinxbase-0.8 install',
    creates => '/usr/local/lib64/pkgconfig/sphinxbase.pc',
  }

  exec { 'retrieve_pocketsphinx_tarball':
    command => '/usr/bin/curl http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz > /tmp/pocketsphinx.tar.gz',
    creates => '/tmp/pocketsphinx.tar.gz',
    require => Package[$dependencies],
  } ~>
  exec { 'untar_pocketsphinx':
    command => '/bin/tar xzf /tmp/pocketsphinx.tar.gz -C /tmp',
    creates => '/tmp/pocketsphinx-0.8',
  } ~>
  exec { 'configure_pocketsphinx':
    cwd       => '/tmp/pocketsphinx-0.8',
    command   => '/bin/bash /tmp/pocketsphinx-0.8/configure',
    creates   => '/tmp/pocketsphinx-0.8/Makefile',
    subscribe => Exec['make_install_sphinxbase'],
  } ~>
  exec { 'make_pocketsphinx':
    command => '/usr/bin/make -C /tmp/pocketsphinx-0.8',
    creates => '/tmp/pocketsphinx-0.8/python/build',
  } ~>
  exec { 'make_install_pocketsphinx':
    command => '/usr/bin/make -C /tmp/pocketsphinx-0.8 install',
    creates => '/usr/local/lib64/pkgconfig/pocketsphinx.pc',
  }

}
