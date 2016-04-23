# puppet-devbox

An opinionated Puppet Module to install and manage your devboxes with various
languages and essential tools.

puppet-devbox is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/devbox).

## Usage

Simply

```puppet
devbox::home = '/home/kevin'

class { '::devbox::lang::python':
}
```

to make your box a _devbox_.
