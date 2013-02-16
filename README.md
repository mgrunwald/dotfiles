# kbmonkey's dotfiles

This repository contains config settings for applications, and bash scripts.

It is a means to backup and synchronize my dotfiles between existing and future machines.

The first phase is to create the structure for our files. The second phase would include a script to bootstrap these dotfiles into your session.

## how to add dotfiles

We hardlink any files into this repo. This seems to satisfy the need to 1) track the content of files changed, and 2) not break links if one or the other disappears.

## list of dotfiles

* .bash_aliases
> aliases to make our shells easier

* .xbindkeysrc
> machine shortcuts for running programs, controlling sound, etc

## how to get it

1) Download the repo from github and extract it to ~/.dotfiles

	https://github.com/wesleywerner/dotfiles

2) Clone it:

	git clone git://github.com/wesleywerner/dotfiles.git ~/.dotfiles

