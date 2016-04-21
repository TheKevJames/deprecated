# puppet-terminal

An opinionated Puppet Module to install and manage your terminals (bash, zsh).

puppet-terminal is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/terminal).

## Usage

Simply

```puppet
class { '::terminal::bash':
  home => '/home/kevin',
}

class { '::terminal::zsh':
  home => '/home/kevin',
}
```

to make sure bash and zsh are installed and configured.

You can also use

```puppet
class { '::terminal':
  home => '/home/kevin',
}
```

to get only the common configuration stuff... but it won't do you much good
without a specific terminal config. If there's some reason you want to use the
base class but not `::bash` or `::zsh`, let me know or submit a PR to fix it!

## Configuration

In addition to the above values set for `terminal::*`, you can also use
hiera to override the following defaults:

```yaml
terminal::os: Linux

terminal::bash::packages:
  - bash
  - bash-completion

terminal::zsh::packages: zsh
```
