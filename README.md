# puppet-devbox

An opinionated Puppet Module to install and manage your devboxes with various
languages and essential tools.

puppet-devbox is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/devbox).

## Usage

Simply

```puppet
class { '::devbox':
  home => '/home/kevin',
}
```

to make your box a _devbox_.

To install and configure any of the submodules, simply include them!

```puppet
# I'm a Python and Android dev checking out Scala in my free time!
include ::devbox::lang::java
include ::devbox::lang::python
include ::devbox::lang::scala
include ::devbox::framework::android
```
