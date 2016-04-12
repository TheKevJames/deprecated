# puppet-consul

A Puppet Module to install and manage [Consul](https://www.consul.io/).

puppet-consul is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/consul).

## Usage

Simply

```puppet
class { '::consul':
  home                 => '/home/kevin',
  datacenter           => 'DC1',
  atlas_infrastructure => 'thekevjames/machines',
  atlas_token          => 'not-my-password',
  server               => true,
}
```

to make sure consul is installed.

## Configuration

In addition to the above value set for `consul`, you can also use hiera to
override the following defaults:

```yaml
consul::dependencies:
  - curl
  - unzip

consul::service_location: /etc/systemd/system/consul.service
consul::service_template: consul/systemd.erb

consul::url: https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip
```
