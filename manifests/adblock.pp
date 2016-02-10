class hosts::adblock {

  include ::hosts

  concat::fragment { 'adblock':
    target  => '/etc/hosts',
    source  => 'puppet:///modules/hosts/adblock',
  }

}
