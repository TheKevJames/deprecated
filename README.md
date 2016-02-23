# puppet-git

An opinionated Puppet Module to install and manage [Git](https://git-scm.com/).

puppet-git is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/git).

## Usage

Simply

```puppet
include ::git
```

to make sure git is installed, or

```puppet
class { '::git::user':
    home     => '/home/kevin',
    fullname => 'Kevin James',
    email    => 'KevinJames@thekev.in',
}
```

to configure git settings.

## Configuration

In addition to the above value set for `git::user`, you can also use
hiera to override the following defaults:

```yaml
git::conflictstyle: diff3
git::browser: google-chrome
git::editor: vim
git::mergetool: vimdiff
git::pager: less -FRX

git::packages: git
```
