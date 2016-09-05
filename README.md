# DevStat

DevStat is an all-in-one page for viewing the status of your various projects.

## Features

(this project is in early development; the below features are a mix of
implemented, partially-implemented, and roadmap)

- auto-discovery of repos
- watch test status, release lag, issue/PR count, etc
- view release stats, stars, downloads, etc
- notification on release of dependent libraries

## Usage

    docker-compose up --build

<!--
## Configuration

This project conforms to the [XDG Base Directory Specification]
(https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).
That means it will search for a `config.yml` in the current directory, then in
the user config directory, then in the `XDG_CONFIG_DIRS`. For example, on Linux
your user-level config should be stored at `~/.config/devstat/config.yml`.

A sample (complicated!) config would look like this:

```
username: TheKevJames

hide:
  - notes

deploy:
  hub.docker:
    - docker-mysqltuner: mysqltuner
    - docker-ubuntu32: thekevjames/ubuntu32

  forge.puppetlabs:
    - puppet-homebrew: homebrew
    - puppet-vault: vault

  pypi.python:
    - aerofs-sdk-python: aerofs
    - python-util

status:
  circleci:
    - devstat
    - dotfiles
    - jarvis
```
-->
