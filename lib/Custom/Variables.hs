module Custom.Variables where

import XMonad

myTerm :: String
myTerm = "alacritty"

myEmacs :: String 
myEmacs = "emacsclient -c -a 'emacs'" 

myFileMan :: String
myFileMan = "thunar"

myColor :: String
myColor = "#df5714"

myNormalBorderColor :: String
myNormalBorderColor = "#1d2021"

myFocusedBorderColor :: String
myFocusedBorderColor = myColor

myBorderWidth :: Dimension
myBorderWidth = 4

myModMask :: KeyMask
myModMask = mod4Mask
