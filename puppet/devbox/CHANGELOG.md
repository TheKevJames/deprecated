# CHANGELOG

## 1.4.2
- bugfix: fix usage of homebrew update command in systems without root pathing set for puppet user

## 1.4.1
- bugfix: fix usage of homebrew update command to run as homebrew user

## 1.4.0
- feature: move some installs from /usr/bin to /usr/local/bin (support OSX El Capitan, etc)
    - c
    - lein
    - python + pip
- minor: install MariaDB in Fedora/Ubuntu
- minor: install Java properly on OSX
- bugfix: fix permissions on MySQL log file
- cleanup: remove unused go::command

## 1.3.1
- bugfix: fix pip path for OpenSuSE
- bugfix: ensure correct pip binary is loaded (given /usr/local/bin generally
          gets searched before /usr/bin)

## 1.3.0
- feature: include database manifests

## 1.2.4
- bugfix: fix regression of venv label on prompt
- bugfix: fix fresh pip install race condition
- bugfix: fix pylintrc format for new pylint versions
- meta: fix test runner

## 1.2.3
- bugfix: fix empty package update command

## 1.2.2
- bugfix: fix tmux right-status query nesting

## 1.2.1
- bugfix: fix tmux right-status quoting

## 1.2.0
- feature: add tool::screen
- feature: add tool::tmux

## 1.1.0
- feature: add tool::docker
- feature: add tool::heroku
- bugfix: update sources before installing

## 1.0.3
- meta: drop unused python3 startup script

## 1.0.2
- bugfix: fix python startup script paths

## 1.0.1
- bugfix: fix root permissions

## 1.0.0
- initial release
