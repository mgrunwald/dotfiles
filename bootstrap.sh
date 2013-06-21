#! /bin/sh
# boot strap all our links
# you may need to place this in .bashrc: source ~/.bash_userrc

# user bashrc
ln -s ~/dotfiles/.bash_userrc ~/

# dunst
mkdir ~/.config/dunst
ln -s ~/dotfiles/.config/dunst/dunstrc ~/.config/dunst/
