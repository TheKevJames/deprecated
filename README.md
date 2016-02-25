# puppet-mpd

An opinionated Puppet Module to install and manage
[Mpd](http://mpd.wikia.com/wiki/Music_Player_Daemon_Wiki).

puppet-mpd is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/mpd).

## Usage

Simply

```puppet
include ::mpd::client
```

to make sure the mpd client is installed, or

```puppet
class { '::mpd::server':
    home      => '/home/kevin',
    music_dir => '/home/kevin/Dropbox/music',
    user      => 'kevin',
}
```

to install and configure the mpd server.

## Configuration

In addition to the above values set for `mpd::server`, you can also use hiera
to override the following defaults:

```yaml
mpd::client::packages: ncmpc

mpd::server::service_location: /etc/systemd/system/mpd.service
mpd::server::service_template: systemd.erb

mpd::server::packages: mpd
```
