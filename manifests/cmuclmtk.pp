# Install and configure cmuclmtk and related jasper dependencies.
class jasper::cmuclmtk($dependencies) {

  require ::subversion

  ensure_packages($dependencies, { ensure => present })

  vcsrepo { '/tmp/cmuclmtk':
    ensure   => present,
    source   => 'https://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk',
    provider => svn,
    force    => true,
  } ~>
  exec { 'autogen_cmuclmtk':
    cwd     => '/tmp/cmuclmtk',
    command => '/tmp/cmuclmtk/autogen.sh',
    creates => '/tmp/cmuclmtk/Makefile',
    require => Package[$dependencies],
  } ~>
  exec { 'make_cmuclmtk':
    cwd     => '/tmp/cmuclmtk',
    command => '/usr/bin/make -C /tmp/cmuclmtk',
    creates => '/tmp/cmuclmtk/src/programs/lm_interpolate',
  } ~>
  exec { 'make_install_cmuclmtk':
    cwd     => '/tmp/cmuclmtk',
    command => '/usr/bin/make -C /tmp/cmuclmtk install',
    timeout => 0,
    creates => '/usr/local/include/cmuclmtk/general.h',
  }

  exec { 'retrieve_openfst_tarball':
    command => '/usr/bin/curl http://distfiles.macports.org/openfst/openfst-1.3.3.tar.gz > /tmp/openfst.tar.gz',
    creates => '/tmp/openfst.tar.gz',
    require => Package[$dependencies],
  } ~>
  exec { 'untar_openfst':
    command => '/bin/tar xzf /tmp/openfst.tar.gz -C /tmp',
    creates => '/tmp/openfst-1.3.3',
  } ~>
  exec { 'configure_openfst':
    cwd     => '/tmp/openfst-1.3.3',
    command => '/bin/bash /tmp/openfst-1.3.3/configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt',
    timeout => 0,
    creates => '/tmp/openfst-1.3.3/Makefile',
  } ~>
  exec { 'make_install_openfst':
    cwd     => '/tmp/openfst-1.3.3',
    command => '/usr/bin/make -C /tmp/openfst-1.3.3 install',
    creates => '/usr/local/lib64/fst/libfstpdtscript.la',
  }

  exec { 'retrieve_mitlm_tarball':
    command => '/usr/bin/curl https://mitlm.googlecode.com/files/mitlm-0.4.1.tar.gz > /tmp/mitlm.tar.gz',
    creates => '/tmp/mitlm.tar.gz',
    require => Package[$dependencies],
  } ~>
  exec { 'untar_mitlm':
    command => '/bin/tar xzf /tmp/mitlm.tar.gz -C /tmp',
    creates => '/tmp/mitlm-0.4.1',
  } ~>
  exec { 'configure_mitlm':
    cwd     => '/tmp/mitlm-0.4.1',
    command => '/bin/bash /tmp/mitlm-0.4.1/configure',
    creates => '/tmp/mitlm-0.4.1/Makefile',
  } ~>
  exec { 'make_mitlm':
    cwd     => '/tmp/mitlm-0.4.1',
    command => '/usr/bin/make -C /tmp/mitlm-0.4.1',
    creates => '/usr/local/lib64/libmitlm.la',
  }

  exec { 'retrieve_m2maligner_tarball':
    command => '/usr/bin/curl https://m2m-aligner.googlecode.com/files/m2m-aligner-1.2.tar.gz > /tmp/m2maligner.tar.gz',
    creates => '/tmp/m2maligner.tar.gz',
    require => Package[$dependencies],
  } ~>
  exec { 'untar_m2maligner':
    command => '/bin/tar xzf /tmp/m2maligner.tar.gz -C /opt',
    creates => '/opt/m2m-aligner-1.2',
  } ~>
  exec { 'make_m2maligner':
    cwd     => '/opt/m2m-aligner-1.2',
    command => '/usr/bin/make -C /opt/m2m-aligner-1.2',
    creates => '/opt/m2m-aligner-1.2/m2m-aligner',
  }

  file { '/usr/local/bin/m2m-aligner':
    ensure  => link,
    target  => '/opt/m2m-aligner/m2m-aligner',
  }

  exec { 'retrieve_phonetisaurus_tarball':
    command => '/usr/bin/curl https://phonetisaurus.googlecode.com/files/phonetisaurus-0.7.8.tgz > /tmp/phonetisaurus.tgz',
    creates => '/tmp/phonetisaurus.tgz',
  } ~>
  exec { 'untar_phonetisaurus':
    command => '/bin/tar xzf /tmp/phonetisaurus.tgz -C /opt',
    creates => '/opt/phonetisaurus-0.7.8',
  } ~>
  exec { 'make_phonetisaurus':
    cwd     => '/opt/phonetisaurus-0.7.8/src',
    command => '/usr/bin/make -C /opt/phonetisaurus-0.7.8/src',
    creates => '/opt/phonetisaurus-0.7.8/phonetisaurus-g2p',
  }

  file { '/usr/local/bin/phonetisaurus-g2p':
    ensure  => link,
    target  => '/opt/phonetisaurus-0.7.8/phonetisaurus-g2p',
  }

  exec { 'retrieve_g014b2b_tarball':
    command => '/usr/bin/curl http://phonetisaurus.googlecode.com/files/g014b2b.tgz > /tmp/g014b2b.tgz',
    creates => '/tmp/g014b2b.tgz',
  } ~>
  exec { 'untar_g014b2b':
    command => '/bin/tar vxzf /tmp/g014b2b.tgz -C /opt',
    creates => '/opt/g014b2b',
  } ~>
  exec { 'make_g014b2b':
    cwd     => '/opt/g014b2b',
    command => '/bin/bash /opt/g014b2b/compile-fst.sh',
    creates => '/opt/g014b2b/g014b2b.fst',
  }

}
