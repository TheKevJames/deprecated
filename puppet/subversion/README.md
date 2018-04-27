# puppet-subversion

An opinionated Puppet Module to install and manage
[Subversion](https://subversion.apache.org/).

puppet-subversion is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/subversion).

## Usage

Simply

```puppet
include ::subversion
```

to make sure subversion is installed, or

```puppet
class { '::subversion::user':
    home => '/home/kevin',
}
```

to configure subversion settings.

## Configuration

In addition to the above value set for `subversion::user`, you can also use
hiera to override the following defaults:

```yaml
subversion::diff3: diff3
subversion::diff: diff
subversion::editor: vim
subversion::mergetool: vimdiff
subversion::passwordstore: gnome-keyring

subversion::packages: subversion
```
