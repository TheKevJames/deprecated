# puppet-sublime

An opinionated Puppet Module to install and manage
[Sublime Text](https://www.sublimetext.com/).

puppet-sublime is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/sublime).

## Usage

Simply

```puppet
class { '::sublime':
  home  => '/home/kevin',
}
```

to make sure sublime is installed.

## Configuration

In addition to the above value set for `sublime`, you can also use
hiera to override the following defaults:

```yaml
```
