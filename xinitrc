# Set background image
feh --bg-scale ~/projects/machine-setup/backgrounds/IDI_018.jpg

# Set up keyboard
# Note: xmodmap must happen after setxkbmap
setxkbmap dvorak
xmodmap ~/.xmodmap

xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr

# Set keyboard repeat to 200 ms delay, 60 repeats per second
xset r rate 200 60

# Set up SCIM input method
export XMODIFIERS=@im=SCIM
export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
scim -d

exec xmonad
