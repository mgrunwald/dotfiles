#!/bin/bash
# a dynamic Command Line Status printer

#Copyright 2012 Wesley (kbmonkey) Werner

#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License
#along with this program.  If not, see <http://www.gnu.org/licenses/>.

# For when just piping to your WM bar isn't enough ;)

# USAGE
# Call this in your ~/.i3/config bar section instead of i3status

# ~/.xbindkeysrc example using Super-F1 to F4:
# use 'xbindkeys --key' to find the key codes.
#
#   "echo 'mode1' > /tmp/clis-mode"
#       Mod2 + Mod4 + F1
#
#   "echo 'mode2' > /tmp/clis-mode"
#       Mod2 + Mod4 + F2
#
#   "echo 'mode3' > /tmp/clis-mode"
#       Mod2 + Mod4 + F3
#
#   "echo 'mode4' > /tmp/clis-mode"
#       Mod2 + Mod4 + F4
#
# NOTIFICATIONS
#
# Write notification strings to /tmp/clis-mode
# to show a quick message.
#
# launch clis at login autostart: clis &
# enjoy toggling your bar infos back and forth :)
#
# kbmonkey!
#
# CHANGES
#
# 2013-04-13
# + adapted for i3wm
#
################################################################################

# help text lists the modes available
HELPLINE="S-F2 Now Playing S-F3 Conky S-F4 Todo"

# append to help text the WM shortcuts
HELPLINE=""$HELPLINE

################################################################################
i3status | (read line && echo $line && read line && echo $line && while :
do
    read line
    
    # get the mode and notification text
    if [ -e "/tmp/clis-mode" ]; then
        ACTION=`cat /tmp/clis-mode` 
        else ACTION=""
        fi
    if [ -e "/tmp/clis-notify" ]; then
        NOTIFY=`cat /tmp/clis-notify`
        else NOTIFY=""
        fi

    # there are notifications
    if [[ "$NOTIFY" != "" ]]; then
        # override the action to bypass the default help text
        ACTION="notify"
        # set the notification text
        INFOLINE="$NOTIFY"
        # remove the notification file
        rm /tmp/clis-notify
        # write to notification history
        echo `date +"%D %T"` "-" $NOTIFY >> /tmp/clis-history
        # foo
        fi
    
    # set the text to display based on what mode is set
    case "$ACTION" in
    mode2)
        # now playing
        INFOLINE="Listening to `ncmpcpp --now-playing '{{%t, by %a, from %b}}|{{%f}}'`"
        ;;
    mode3)
        # top processes
        INFOLINE="`ps -eo '%C%% %c' | sort -k1 -n -r | head -2 | tr '\n' ' '`"
        ;;
    mode4)
        # next calcurse appointment and top todo item
        # must remove tabs and linebreaks
        INFOLINE=`calcurse --day 30 | tr '\n' ' ' | tr '\t' ' '`
        INFOLINE="$INFOLINE  `cat ~/.calcurse/todo | head -n 1`"
        ;;
    notify)
        # notification text
        # this is here simply to bypass the *) test from setting the $HELPLINE
        ;;  
    *)
        # hotkey help
        INFOLINE=$HELPLINE
        ;;
    esac

    # append the time
    #INFOLINE="$INFOLINE #! `date +%T`"
    INFOLINE="$INFOLINE [#!]"
    
    # emit the i3status text along with our custom string
    dat="[{ \"full_text\": \"${INFOLINE}\" },"
    echo "${line/[/$dat}" || exit 1
   
done)
