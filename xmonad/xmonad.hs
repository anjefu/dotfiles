import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Grid
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

myManageHook = composeAll
  [ className =? "Emacs"                --> doShift "1"
  , className =? "Google-chrome-stable" --> doShift "2"
  , className =? "Firefox"              --> doShift "2"
  , className =? "Thunderbird"          --> doShift "8"
  , title =? "alsamixer"                --> doShift "9"
  , title =? "ncmpcpp"                  --> doShift "9"
  , className =? "Gimp"                 --> doFloat
  , manageDocks
  ]

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
         { workspaces = ["1","2","3","4","5","6","7","8","9"]
         , modMask = mod4Mask
         , normalBorderColor = "#dddddd"
         , focusedBorderColor = "#113311"
         , manageHook = myManageHook <+> manageHook defaultConfig
         , layoutHook = avoidStruts $ smartBorders $ ThreeColMid 1 (3/100) (1/3) ||| Grid ||| layoutHook defaultConfig
         , logHook = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "blue" "" . shorten 50
--           , ppLayout = const "" -- to disable the layout info on xmobar
           }
         , terminal = "/usr/bin/xterm"
         } `additionalKeys`
         [ ((mod4Mask .|. shiftMask, xK_f), spawn "firefox")
         , ((mod4Mask .|. shiftMask, xK_i), spawn "google-chrome-stable")
         , ((mod4Mask .|. shiftMask, xK_t), spawn "emacs")
         , ((mod4Mask .|. shiftMask, xK_l), spawn "light-locker-command --lock")
         , ((mod4Mask .|. shiftMask, xK_n), spawn "pcmanfm")
         , ((mod4Mask .|. shiftMask, xK_r), spawn "reboot")
         , ((mod4Mask .|. shiftMask, xK_p), spawn "poweroff")

         -- Multimedia keys
         , ((0, 0x1008FF11), spawn "amixer -q set Master on; amixer -q set Master 5-") -- XF86AudioLowerVolume
         , ((0, 0x1008FF12), spawn "amixer -q set Master toggle") -- XF86AudioMute
         , ((0, 0x1008FF13), spawn "amixer -q set Master on; amixer -q set Master 5+") -- XF86AudioRaiseVolume
         , ((0, 0x1008FFB2), spawn "amixer -q set Mic toggle") -- XF86AudioMicMute
--         , ((0, 0x1008FF41), spawn "") -- XF86Launch1 (ThinkVantage button)
         , ((0, 0x1008FF02), spawn "xbacklight -inc 10") -- XF86MonBrightnessUp
         , ((0, 0x1008FF03), spawn "xbacklight -dec 10") -- XF86MonBrightnessDown
--         , ((0, 0x1008FF14), spawn "") -- XF86AudioPlay
--         , ((0, 0x1008FF16), spawn "") -- XF86AudioPrev
--         , ((0, 0x1008FF17), spawn "") -- XF86AudioNext
         , ((0, 0xFF61), spawn "scrot") -- Print
         , ((0, 0x1008FF2D), spawn "xcreensaver-command --lock") -- XF86ScreenSaver
         ]
