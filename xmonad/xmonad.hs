import Graphics.X11.ExtraTypes.XF86
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Layout.MultiColumns
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (spawnPipe)

myManageHook = composeAll
  [ resource =? "Mail"      --> doShift "8"
  , manageDocks
  ]

myTerminal = "urxvt"

myKeys = [ ((mod4Mask .|. shiftMask, xK_f), spawn "~/projects/scripts/scim-open-app.sh firefox")
         , ((mod4Mask .|. shiftMask, xK_c), spawn "~/projects/scripts/scim-open-app.sh google-chrome-stable")
         , ((mod4Mask .|. shiftMask, xK_m), spawn "~/projects/scripts/scim-open-app.sh thunderbird")
         , ((mod4Mask .|. shiftMask, xK_i), spawn "~/projects/scripts/invert-colors.sh")
         , ((mod4Mask .|. shiftMask, xK_t), spawn "emacs")
         , ((mod4Mask .|. shiftMask, xK_l), spawn "light-locker-command --lock")
         , ((mod4Mask .|. shiftMask, xK_n), spawn "pcmanfm")
         , ((mod4Mask .|. shiftMask, xK_r), spawn "reboot")
         , ((mod4Mask .|. shiftMask, xK_p), spawn "poweroff")
         , ((0, xF86XK_AudioLowerVolume)  , spawn "amixer -q set Master on; amixer -q set Master 5-")
         , ((0, xF86XK_AudioMute)         , spawn "amixer -q set Master toggle")
         , ((0, xF86XK_AudioRaiseVolume)  , spawn "amixer -q set Master on; amixer -q set Master 5+")
--       , ((0, xF86XK_AudioMicMute)      , spawn "amixer -q set Mic toggle")
         , ((0, xF86XK_Launch1)           , spawn (myTerminal ++ " -e top"))
         , ((0, xF86XK_Display)           , spawn "xrandr --auto")
         , ((0, xF86XK_MonBrightnessUp)   , spawn "xbacklight -inc 10")
         , ((0, xF86XK_MonBrightnessDown) , spawn "xbacklight -dec 10")
         , ((0, xF86XK_AudioPlay)         , spawn "ncmpcpp toggle")
         , ((0, xF86XK_AudioPrev)         , spawn "ncmpcpp prev")
         , ((0, xF86XK_AudioNext)         , spawn "ncmpcpp next")
         , ((0, xK_Print)                 , spawn "scrot")
         , ((mod4Mask .|. shiftMask , xK_Print) , spawn "sleep 0.2; scrot -s")
         , ((0, xF86XK_ScreenSaver)       , spawn "xcreensaver-command --lock")
         ]

myLayouts =   (smartSpacing s $ Tall nmaster delta ratio)
          ||| (smartSpacing s . Mirror $ Tall nmaster delta ratio)
          ||| (smartSpacing s $ Full)
          ||| (smartSpacing s $ ThreeColMid nmaster delta ratio)
          ||| (smartSpacing s $ multiCol [1] nmaster delta (-0.5))
          ||| (smartSpacing s $ Grid)
  where
    s       = 5
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ def
         { workspaces         = map show [1..9]
         , modMask            = mod4Mask
         , normalBorderColor  = "#555555"
         , focusedBorderColor = "#0055AA"
         , borderWidth        = 3
         , manageHook         = myManageHook <+> manageHook defaultConfig
         , layoutHook         = avoidStruts . smartBorders $ myLayouts
         , terminal           = myTerminal
         , logHook            = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "blue" "" . shorten 50
--         , ppLayout = const "" -- to disable the layout info on xmobar
           }
         } `additionalKeys` myKeys
