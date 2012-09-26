xloadimage -onroot -tile ~/projects/machine-setup/backgrounds/textured-grey.png
setxkbmap dvorak
xmodmap ~/.xmodmap   # Note: xmodmap must happen after setxkbmap
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr
exec xmonad
