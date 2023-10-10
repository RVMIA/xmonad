module Custom.Keys where

import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.NoBorders
import Custom.Variables


myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
  [ ((myModMask, xK_f), spawn "firefox-bin")
  , ((myModMask .|. shiftMask, xK_f), spawn "google-chrome-stable")
  , ((myModMask, xK_q), spawn "xmonad --restart")
  , ((myModMask .|. shiftMask, xK_l), spawn "slock")
  , ((myModMask .|. shiftMask, xK_p), spawn "spotify")
  , ((myModMask, xK_p), spawn "dmenu_run")
  , ((myModMask .|. shiftMask, xK_d), spawn "discord")
  , ((myModMask .|. shiftMask, xK_s), spawn "maim -s /home/ame/Pictures/screenshots/$(date +%s)-screenshot.png && thunar ~/Pictures/screenshots/")
  , ((myModMask .|. shiftMask, xK_t), spawn myFileMan)
  , ((myModMask .|. shiftMask, xK_e), spawn myEmacs)
  , ((myModMask .|. shiftMask, xK_b), withFocused toggleBorder)
  , ((myModMask .|. shiftMask, xK_r), spawn "bash /home/ame/.config/screenlayout.sh")
  , ((0, xF86XK_AudioPlay) , spawn "playerctl -p spotify play-pause")
  , ((0, xF86XK_AudioPrev) , spawn "playerctl -p spotify previous")
  , ((0, xF86XK_AudioNext) , spawn "playerctl -p spotify next")
  ]
