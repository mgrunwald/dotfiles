# kbmonkey's dotfiles

This repo contains configs and bash scripts.

It is a means to backup and synchronize my dotfiles between existing and future machines.

The first phase is to create the structure for our files. The second phase would include a script to bootstrap these dotfiles into your session. For the moment I include instructions below how to manually bootstrap these files.

## list of dotfiles

* .bash_profile
> sets user paths and environment variables

* .bash_aliases
> bash aliases for a nicer shell

* .xbindkeysrc
> global shortcuts for easier living

* .keynavrc
> for keynav, controlling your mouse with the keyboard

## how to get it

1) Download the repo from github and extract it to ~/.dotfiles

	https://github.com/wesleywerner/dotfiles

2) Clone it:

	git clone git://github.com/wesleywerner/dotfiles.git ~/.dotfiles

## how to link dotfiles

We hardlink dotfiles out of this repo. This seems to satisfy the need to 1) track the content of files changed, and 2) not break links if one or the other disappears.

Backup current dotfiles:

    mv ~/.bash_aliases ~/.bash_aliases.dotfilebak
    mv ~/.xbindkeysrc ~/.xbindkeysrc.dotfilebak
    mv ~/.keynavrc ~/.keynavrc.dotfilebak
    mv ~/.bash_profile ~/.bash_profile.dotfilebak

Hard link the new files in:

    ln ~/dotfiles/.bash_aliases ~/
    ln ~/dotfiles/.xbindkeysrc ~/
    ln ~/dotfiles/.keynavrc ~/
    ln ~/dotfiles/.bash_profile ~/

Thus any changes to your dotfiles will show up in the ~/dotfiles repo automatically. 

## syncing changes between machines

After changing one of the dotfiles, commit the changes and push them upstream to github:

    ~/dotfiles/:$ git commit .
    ~/dotfiles/:$ git push

_Of course you can only push to your own forked repo._

Then pull changes into any other machines via:

    ~/dotfiles/:$ git pull

## automatic syncing

Included is sync.sh which will pull and commit any changed dotfiles. Add this to your crontab (crontab -e). This syncs every hour:

    @hourly	sh ~/dotfiles/sync.sh

That is all.
