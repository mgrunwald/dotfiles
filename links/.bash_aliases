# coding
alias code='cd ~/coding/games/aliverl/data/'
alias mvc='cd ~/coding/mvc-game-design/'

# terminal recording
alias recordterm='export TERM=vt100; ttyrec ~/ttyrecordings/`date +%Y-%m-%d_@_%H:%M:%S`'

# ls with color for humans
alias ls='ls -hp --color=auto'

# detailed file list
alias ll='ls -hl'

# detailed with hidden
alias la='ls -hal'

# grep with color
alias grep='grep -i --color=auto'

# mountpoints with fs type for humans
alias df='df -Th'

# directory usage for humans
alias du='du -h'

# free memory for humans
alias free='echo "Memory free in MiB" && free -m'

# up dir shortcut
alias ..='cd ..'

# rsync with progress
alias rsync='rsync --progress'

# average cpu usage by process
alias avg-cpu='ps -o "%cpu" -C $1'

# coffee timer
alias coffee='(sleep 270 && zenity --info --title="coffee" --text="Coffee ready\!") &'

# apt shorthand
# note: does not support tab-completion but useful as a quick search.
alias aptsearch='apt-cache search'
alias aptshow='apt-cache show'

# cli clipboard support
alias clip='xclip -sel clip'

# audio transcoding
alias convert-ogg-to-mp3='for f in *.ogg; do ffmpeg -i "$f" -acodec libmp3lame "${f%%.ogg}.mp3"; done'
alias convert-wma-to-mp3='for f in *.wma; do ffmpeg -i "$f" -acodec libmp3lame "${f%%.wma}.mp3"; done'

# system power commands
alias reboot="sudo reboot"
alias poweroff="sudo poweroff"
alias halt="sudo halt"

# reload xbindkeys config
alias xbindkeysreloadconf='killall xbindkeys && xbindkeys &'
