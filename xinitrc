xloadimage -onroot -tile ~/projects/machine-setup/backgrounds/textured-grey.png
setxkbmap dvorak
xmodmap ~/.xmodmap   # Note: xmodmap must happen after setxkbmap
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
