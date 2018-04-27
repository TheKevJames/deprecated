# puppet-jasper

An opinionated Puppet Module to install and manage
[Jasper](https://jasperproject.github.io/).

puppet-jasper is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/jasper).

## Usage

Simply

```puppet
class { '::jasper':
    home           => '/home/kevin',
    email_address  => 'KevinJames@thekev.in',
    email_password => 'passw0rd',
    first_name     => 'kevin',
    last_name      => 'james',
    phone          => '2058675309'
    carrier        => 'vmobile.ca',
    location       => 'Toronto',
    timezone       => 'America/Toronto',
}

```

to make sure jasper is installed.
