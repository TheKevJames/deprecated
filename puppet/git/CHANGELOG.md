# CHANGELOG

## 1.4.2
- bugfix: use global pylintrc in pre-commit hook

## 1.4.1
- bugfix: allow usage of multiple utilities

## 1.4.0
- feature: add git utilities: git-forest, git-rank-contributors, git-wtf

## 1.3.2
- feature: ensure !/.config folder exists

## 1.3.1
- feature: parameterize difftool for non-hiera

## 1.3.0
- feature: git::mergetool -> git::difftool (now configures difftool as well!)
- compatibility: compatible with neovim (use difftool: nvimdiff).

## 1.2.1
- bugfix: fix XDG_CONFIG_HOME pathing

## 1.2.0
- feature: use XDG_CONFIG_HOME
- compatibility: improve package compatibility by using ensure_packages

## 1.1.2
- feature: add $tar parameter to ::git

## 1.1.1
- feature: allow configuration of tar binary location

## 1.1.0
- feature: add hub tool

## 1.0.0
- initial release
