# puppet-vault

A Puppet Module to install and manage Vault.

puppet-vault is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/vault).

## Usage

Simply

```puppet
include ::vault
```

## Configuration

The module will configure your vault instance with hiera. Somewhere in your
hiera files, set:

```yaml
vault::config: |
    {
        "backend": {
            "file": {
                "path": "/etc/vault.d/store"
            }
        },
        "listener": {
            "tcp": {
                "address": "127.0.0.1:8200",
                "tls_disable": 1
            }
        }
    }
```

Note that the above is set by default, so you only need to overwrite it if you
do not want the default values.
