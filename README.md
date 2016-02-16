# puppet-bazaar

An opinionated Puppet Module to install and manage
[Bzr](http://bazaar.canonical.com/en/).

puppet-bazaar is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/bazaar).

## Usage

Simply

```puppet
include ::bazaar
```

to make sure bazaar is installed, or

```puppet
class { '::bazaar::user':
    home     => '/home/kevin',
    fullname => 'Kevin James',
    email    => 'KevinJames@thekev.in',
}
```

to configure bazaar settings.

## Configuration

In addition to the above values set for `bazaar::user`, you can also use hiera
to override the following defaults:

```yaml
bazaar::editor: vim
bazaar::mergetool: vimdiff
bazaar::tabwidth: 4
```
