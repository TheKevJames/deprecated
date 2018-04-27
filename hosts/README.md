# puppet-hosts

An opinionated Puppet Module to configure your /etc/hosts file. Supports
hosts-based adblocking and shock-site blocking.

puppet-hosts is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/hosts).

## Usage

Manage your hosts file with:

```puppet
include ::hosts
```

and, to enable adblocking or shock-site blocking, include:

```puppet
include ::hosts::adblock
include ::hosts::shock
```
