class hosts {

  concat { '/etc/hosts':
    mode  => '0644',
    owner => root,
    group => root,
    warn  => true,
  }

  concat::fragment { 'default':
    target  => '/etc/hosts',
    content => template('hosts/default.erb'),
  }

}
