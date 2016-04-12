class { '::consul':
  home           => '/root',
  datacenter     => 'DC1',
  infrastructure => 'test/machines',
  server         => true,
}
