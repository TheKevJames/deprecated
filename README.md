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

to make sure bash and zsh are installed and configured. Feel free to use both
if you need both terminals configured!

If you're an OSX user that wants to avoid homebrew+github rate limiting, set

```puppet
class { '::terminal::zsh':
  home                      => '/home/kevin',
  homebrew_github_api_token => 'IMASECRETSSSHDONTTELLANYONE',
}
```

or, of course, use `::terminal::bash`.


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
