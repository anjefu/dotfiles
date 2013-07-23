# Configure X
xsetroot -solid '#333'
feh --bg-scale ~/projects/machine-setup/backgrounds/grey-squares.jpg
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources

~/projects/scripts/init-keyboard.sh

# Set up SCIM input method
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
scim -d

# System tray
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --height 12 --transparent true --tint 0x000000 &

# Network manager applet
nm-applet --sm-disable &

# Music player daemon
mpd ~/.mpdconf

# Applications
emacs &
google-chrome &
xterm -e alsamixer &
xterm -e ncmpcpp -s playlist-editor &
thunderbird &

exec xmonad
