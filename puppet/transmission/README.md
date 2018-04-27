# puppet-transmission

An opinionated Puppet Module to install and manage
[Transmission](https://www.transmissionbt.com/).

puppet-transmission is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/transmission).

## Usage

Simply

```puppet
include ::transmission
```

to make sure transmission is installed, or

```puppet
class { '::transmission::daemon':
    home     => '/home/kevin',
    user     => 'kevin',
    password => 'insert_hash_here',
}

class { '::transmission::gui':
    home => '/home/kevin',
}
```

to configure transmission settings for either the daemon or the gui. Note that
the daemon is unavailable on Darwin.

## Configuration

In addition to the above value set for `transmission::daemon` and
`transmission::gui`, you can also use hiera to override the following defaults:

```yaml
transmission::packages: transmission

transmission::daemon::packages: transmission-daemon
```
