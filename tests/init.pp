class { '::consul':
  home                 => '/root',
  datacenter           => 'DC1',
  atlas_infrastructure => 'test/machines',
  atlas_token          => 'ITS-A-SECRET',
  server               => true,
}
