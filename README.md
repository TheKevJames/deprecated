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

You can also install the [Hub](https://hub.github.com/) tool with

```puppet
include ::git::hub
```

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
git::tar: /bin/tar

git::hub::url: https://github.com/github/hub/releases/download/v2.2.3/hub-linux-amd64-2.2.3.tgz
```
