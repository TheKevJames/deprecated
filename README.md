# puppet-irssi

An opinionated Puppet Module to install and manage [Irssi](https://irssi.org/).

puppet-irssi is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/irssi).

## Usage

Simply

```puppet
class { '::irssi':
  home     => '/home/kevin',
  fullname => 'Kevin James',
  username => 'thekevjames',
  password => 'aardvarkz_rule!!!!1!!'
}
```
