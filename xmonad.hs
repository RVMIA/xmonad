import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Loggers


import XMonad.ManageHook
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers

myTerm = "kitty"
myModMask = mod4Mask
myBorderWidth = 3
myNormalBorderColor  = "#222222"
myFocusedBorderColor = "#DE5e5e"


main :: IO ()
main = xmonad
       . ewmhFullscreen
       . ewmh
       . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobar/xmobar.hs" (pure myXmobarPP)) defToggleStrutsKey
       $ myConfig 
	
myConfig = def
	{ terminal = myTerm 
	, modMask = myModMask 
	, borderWidth = myBorderWidth
	, normalBorderColor = myNormalBorderColor
	, focusedBorderColor = myFocusedBorderColor
	, manageHook = myManageHook
	, layoutHook = myLayout
	}
	`additionalKeysP`
	[ ("M-f", spawn "firefox-bin")
	, ("M-S-l", spawn "slock")
	, ("M-S-e", spawn "emacs")
        , ("M-S-s", spawn "spotify")
	]

myManageHook :: ManageHook
myManageHook = composeAll
	[ className =? "Gimp" --> doFloat
	, isDialog	      --> doFloat ]

myLayout = (tiled ||| Mirror tiled |||  Full)
	where
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio = 1/2
		delta = 3/100

myXmobarPP :: PP
myXmobarPP = def
  { ppSep             = walred " | "
  , ppTitleSanitize   = xmobarStrip
  , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
  , ppHidden          = white . wrap " " ""
  , ppHiddenNoWindows = lowWhite . wrap " " ""
  , ppUrgent          = red . wrap (yellow "!") (yellow "!")
  , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
  , ppExtras          = [logTitles formatFocused formatUnfocused]
  }
  where
    formatFocused   = wrap (white    "[") (white    "]") . walred . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . grey . ppWindow
  
    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow, walred, grey :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    grey = xmobarColor "#8e8e8e" ""
    walred = xmobarColor "#de5e5e" ""