import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import Graphics.X11.ExtraTypes.XF86

myManageHook = composeAll
  [ resource =? "emacs"     --> doShift "1"
  , resource =? "Navigator" --> doShift "2"
  , resource =? "Mail"      --> doShift "8"
  , manageDocks
  ]

myTerminal = "urxvt"

myKeys = [ ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")
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
         , ((0, xF86XK_ScreenSaver)       , spawn "xcreensaver-command --lock")
         ]

myLayouts =   (smartSpacing 10 $ Tall nmaster delta ratio)
          ||| (smartSpacing 10 $ Mirror (Tall nmaster delta ratio))
          ||| (smartSpacing 10 $ Full)
          ||| (smartSpacing 10 $ ThreeColMid nmaster delta ratio)
          ||| (smartSpacing 10 $ Grid)
  where
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
         { workspaces         = map show [1..9]
         , modMask            = mod4Mask
         , normalBorderColor  = "#dddddd"
         , focusedBorderColor = "#113311"
         , manageHook         = myManageHook <+> manageHook defaultConfig
         , layoutHook         = avoidStruts $ smartBorders $ myLayouts
         , terminal           = myTerminal
         , logHook            = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "blue" "" . shorten 50
--         , ppLayout = const "" -- to disable the layout info on xmobar
           }
         } `additionalKeys` myKeys
