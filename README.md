# puppet-jasper

An opinionated Puppet Module to install and manage
[Jasper](https://jasperproject.github.io/).

puppet-jasper is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/jasper).

## Usage

Simply

```puppet
class { '::jasper':
}
```

to make sure jasper is installed.

## Configuration

In addition to the above value set for `ngrok`, you can also use
hiera to override the following defaults:

```yaml
```
