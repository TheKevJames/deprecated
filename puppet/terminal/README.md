# puppet-terminal

An opinionated Puppet Module to install and manage your terminals (bash, zsh).

puppet-terminal is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/terminal).

## Usage

Simply

```puppet
class { '::terminal':
  home => '/home/kevin',
}

include ::terminal::bash
include ::terminal::zsh
```

to make sure bash and zsh are installed and configured. Feel free to use both
if you need both terminals configured!

To get some standard terminal utilities, simply

```puppet
include ::terminal::utilies
```

If you're an OSX user that wants to avoid homebrew+github rate limiting, set

```puppet
class { '::terminal':
  home                      => '/home/kevin',
  homebrew_github_api_token => 'IMASECRETSSSHDONTTELLANYONE',
}
```

## Configuration

In addition to the above values set for `terminal::*`, you can also use
hiera to override the following defaults:

```yaml
terminal::bash:os: Linux
terminal::bash::packages:
  - bash
  - bash-completion

terminal::utilities::os: Linux
terminal::utilities::packages:
  - autoconf
  - automake
  - curl
  - jq
  - less
  - make
  - pkg-config
  - the_silver_searcher
  - unzip
  - wget

terminal::zsh:os: Linux
terminal::zsh::packages: zsh
```
