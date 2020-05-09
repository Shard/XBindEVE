# XBindEVE

![Project Status: Alpha](https://img.shields.io/badge/project status-alpha-red)

A plugin for [xbindkeys](https://ddg.gg/xbindkeys) that asissts switching between multiple EVE Online clients within a X11 session. Is currently functional but is still under development and probably will see changes in the future.

## How to install

### Dependencies

Asside from `xbindkeys`, the only dependency for `xbindeve` is [wmctrl](https://ddg.gg/wmctrl)

### Downloading

Simply [download](https://github.com/shard/xbindeve/raw/master/xbindeve.scm) the `xbindeve.scm` file to somewhere you can load it.

```bash
wget https://github.com/shard/xbindeve/raw/master/xbindeve.scm
```

### Setting up xbindkeys

First you will need to create `~/.xbindkeysrc.scm` in your HOME folder if it doesn't exist and add the following:

```guile
(load "./xbindeve.scm") ; path to xbindeve.scm
(define eve-accounts '(
                       ("Toon 1" "Toon 2")
                       ("Toon 3"))) ; Your eve accounts, grouped by account
(eve-sync) ; sync the loaded clients
(xbindkey '(control "1") (eve-open 0)) ; Bind control + 1 to Toon 1 and Toon 2
(xbindkey '(control "2") (eve-open 1)) ; Bind control + 2 to Toon 3
```

## Current Issues

- [ ] Currently only supports 6 client groups, need to fix `(eve-active)` to match length of `(eve-accounts)`
- [ ] `(eve-sync)` needs to be ran more often than at xbindkeys initialisation, but shouldn't run before every switch
  - If a resync of clients is required, run `xbindkeys --poll-rc` to resolve the issue
- [ ] Add throttling to `(eve-sync)` to ensure it doesn't run too quickly, leading to a crash
- [ ] Add a function to autobind xbindkey, making config simpler
  - Will need to consider how to make it flexible for other configurations asside from CTRL + 1-9
- [ ] Better install instructions

### I have a problem!

Feel free to create a new issue on github if you are having issues installing, running or want to see a new feature added.
