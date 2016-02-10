class hosts::shock {

  include ::hosts

  concat::fragment { 'shock':
    target  => '/etc/hosts',
    source  => 'puppet:///modules/hosts/shock',
  }

}
