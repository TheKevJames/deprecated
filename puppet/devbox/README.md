# puppet-devbox

An opinionated Puppet Module to install and manage your devboxes with various
languages and essential tools.

puppet-devbox is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/devbox).

## Usage

Simply

```puppet
class { '::devbox':
  home => '/home/kevin',
}
```

to make your box a _devbox_.

To install and configure any of the submodules, simply include them!

```puppet
include ::devbox::db::mariadb
include ::devbox::db::mysql
include ::devbox::db::postgres
include ::devbox::db::redis
include ::devbox::db::sqlite
include ::devbox::framework::android
include ::devbox::lang::c
include ::devbox::lang::clojure
include ::devbox::lang::go
include ::devbox::lang::java
include ::devbox::lang::javascript
include ::devbox::lang::ocaml
include ::devbox::lang::perl
include ::devbox::lang::php
include ::devbox::lang::python
include ::devbox::lang::ruby
include ::devbox::lang::scala
include ::devbox::tool::docker
include ::devbox::tool::heroku
include ::devbox::tool::screen
include ::devbox::tool::tmux
```
