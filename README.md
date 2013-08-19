# mgrunwalds dotfiles

This repo contains configs and bash/zsh scripts.

It is a means to backup and synchronize my dotfiles between existing and future machines.

# Adding new dotfiles

move the file into the `links` directory, this is analogous to the $HOME path. Run the bootstrap script to link the file locally.

# Bootstrapping

Run `bootstrap.sh` to link all files under `links` into your $HOME. Directory structure is maintained.

## how to get it

1) Download the repo from github and extract it to `~/dotfiles`

    https://github.com/wesleywerner/dotfiles

2) Clone it:

    git clone git://github.com/wesleywerner/dotfiles.git ~/

## Syncing machines

Included is [sync.sh](sync.sh) which will pull, add new and commit any changed dotfiles. Add this to your cron jobs (crontab -e). This syncs every 4 hours:

    0   */4 *   *   *   sh ~/dotfiles/sync.sh

## Finding broken links

For help to find broken links in your $HOME. Increase maxdepth as needed.

    find -L $HOME -type l -maxdepth 2

If you want to delete these, use:

    find -L $HOME -type l -maxdepth 2 -delete

That is all.
