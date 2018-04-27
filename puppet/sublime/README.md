# puppet-sublime

An opinionated Puppet Module to install and manage
[Sublime Text](https://www.sublimetext.com/).

puppet-sublime is available on the
[Puppet Forge](https://forge.puppetlabs.com/thekevjames/sublime).

## Usage

Simply

```puppet
class { '::sublime':
  font_dir => '/home/kevin/Dropbox/fonts',
  home     => '/home/kevin',
  plugins  => ["BracketHighlighter",
              "Case Conversion",
              "Increment Selection"],
}
```

to make sure sublime is installed. The `font_dir` and `plugins` keys are
optional.

## Configuration

In addition to the above value set for `sublime`, you can also use
hiera to override the following defaults:

```yaml
sublime::binary_file: /opt/sublime_text_3/sublime_text
sublime::dependencies:
  - curl
  - tar
sublime::download_url: https://download.sublimetext.com/sublime_text_3_build_3103_x64.tar.bz2
sublime::keymap_name: Linux
sublime::package_file: sublime-text-3.tar.bz2
sublime::user_font_dir: .local/share/fonts
```
