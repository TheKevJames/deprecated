class hosts ($adblock = false, $shock = false) {

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

  if $adblock {
    concat::fragment { 'adblock':
      target  => '/etc/hosts',
      source  => 'puppet:///modules/hosts/adblock',
    }
  }
  if $shock {
    concat::fragment { 'shock':
      target  => '/etc/hosts',
      source  => 'puppet:///modules/hosts/shock',
    }
  }

}
