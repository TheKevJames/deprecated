# puppet-clementine

An opinionated Puppet Module to install and manage
[Clementine](https://www.clementine-player.org/).

puppet-clementine is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/clementine).

## Usage

Simply

```puppet
class { '::clementine':
    home      => '/home/kevin',
    music_dir => '/home/kevin/Dropbox/music',
}
```

to make sure clementine is installed.

## Configuration

In addition to the above value set for `clementine`, you can also use
hiera to override the following defaults:

```yaml
clementine::config_file: ${clementine::home}/.config/Clementine/Clementine.conf
clementine::config_folder: ${clementine::home}/.config/Clementine
clementine::config_template: config.linux.erb

clementine::packages: clementine
```
