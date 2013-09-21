import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)

myManageHook = composeAll
  [ className =? "Emacs"         --> doShift "1:dev"
  , className =? "Google-chrome" --> doShift "2:web"
  , className =? "Firefox"       --> doShift "2:web"
  , className =? "Thunderbird"   --> doShift "8:mail"
  , title =? "alsamixer"         --> doShift "9:audio"
  , title =? "ncmpcpp"           --> doShift "9:audio"
  , className =? "Gimp"          --> doFloat
  , manageDocks
  ]

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
         { workspaces = ["1:dev","2:web","3:term","4","5","6","7","8:mail","9:audio"]
         , modMask = mod4Mask
         , normalBorderColor = "#dddddd"
         , focusedBorderColor = "#339933"
         , manageHook = myManageHook <+> manageHook defaultConfig
         , layoutHook = avoidStruts $ layoutHook defaultConfig
         , logHook = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "blue" "" . shorten 50
--           , ppLayout = const "" -- to disable the layout info on xmobar
           }
         , terminal = "/usr/bin/xterm"
         } `additionalKeys`
         [ ((mod4Mask .|. shiftMask, xK_i), spawn "google-chrome")
         , ((mod4Mask .|. shiftMask, xK_t), spawn "emacs")
         , ((mod4Mask .|. shiftMask, xK_l), spawn "slimlock")
         , ((mod4Mask .|. shiftMask, xK_n), spawn "pcmanfm")
         , ((mod4Mask .|. shiftMask, xK_r), spawn "reboot")
         , ((mod4Mask .|. shiftMask, xK_p), spawn "poweroff")
         ]
