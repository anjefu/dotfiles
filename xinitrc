# Configure X
xsetroot -solid '#333'
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources

~/projects/scripts/init-keyboard.sh
~/projects/scripts/setup-background.sh

# Set up SCIM input method
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
scim -d

# System tray
~/projects/scripts/setup-tray.sh

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
