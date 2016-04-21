# puppet-devbox

An opinionated Puppet Module to install and manage your devboxes with various
languages and essential tools.

puppet-devbox is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/devbox).

## Usage

Simply

```puppet
class { '::devbox':
}
```

to make your box a _devbox_.

## Configuration

In addition to the above values set for `devbox`, you can also use
hiera to override the following defaults:

```yaml
```
