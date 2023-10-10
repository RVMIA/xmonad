module Custom.Defaults where

import Custom.Keys
import Custom.Variables
import XMonad
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.SpawnOnce

defaults = def
  { modMask = myModMask
  , terminal = myTerm 
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , startupHook = myStartupHook
  , manageHook = myManageHook
  , handleEventHook = myHandleEventHook  --  window swallowing
  , layoutHook = myLayout
  } `additionalKeys` myKeys

myLayout =  (lessBorders Screen) $ (tiled ||| Mirror tiled ||| Full)
  where
    tiled =  smartSpacingWithEdge 10 $ Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "nitrogen --restore &"
  spawnOnce "setxkbmap -option caps:escape &"
  spawnOnce "picom -b &"
  spawnOnce "dunst &"
  spawnOnce "emacs --daemon &"

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      isDialog --> doFloat,
      className =? "Spotify" --> doShift "9",
      className =? "discord" --> doShift "9",
      className =? "SpeedCrunch" --> doFloat
    ]

myHandleEventHook = swallowEventHook (className =? "Kitty" <||> className =? "Alacritty") (return True)

