# puppet-neovim

An opinionated Puppet Module to install and manage [Neovim](https://neovim.io/).

puppet-neovim is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/neovim).

## Usage

Simply

```puppet
class { '::neovim':
  home => '/home/kevin',
}
```

to make sure neovim is installed.

## Configuration

In addition to the above value set for `neovim`, you can also use
hiera to override the following defaults:

```yaml
neovim::packages: neovim
```
