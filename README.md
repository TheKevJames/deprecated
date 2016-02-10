# puppet-hosts

An opinionated Puppet Module to configure your /etc/hosts file. Supports
hosts-based adblocking and shock-site blocking.

puppet-hosts is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/hosts).

## Usage

Manage your hosts file with:

```puppet
include hosts
```

or, for adblocking and shock-site blocking, use:

```puppet
class hosts: {
  adblock => true,   # Defaults to false
  shock   => true,   # Defaults to false
}
```
