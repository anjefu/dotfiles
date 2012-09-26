import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
         { modMask = mod4Mask
         , normalBorderColor = "#dddddd"
         , focusedBorderColor = "#339933"
         , manageHook = manageDocks <+> manageHook defaultConfig
         , layoutHook = avoidStruts $ layoutHook defaultConfig
         , logHook = dynamicLogWithPP xmobarPP
           { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "blue" "" . shorten 50
           , ppLayout = const "" -- to disable the layout info on xmobar
           }
         } `additionalKeys`
         [ ((mod4Mask .|. shiftMask, xK_c), spawn "chromium")
         , ((mod4Mask .|. shiftMask, xK_e), spawn "emacs")
         , ((mod4Mask .|. shiftMask, xK_l), spawn "xlock -mode blank")
         ]
