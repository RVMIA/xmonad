import System.Exit
import System.Posix.Process
import Control.Monad
import Graphics.X11.ExtraTypes.XF86

import XMonad

import XMonad.ManageHook
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing

import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Man
import XMonad.Prompt.XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.Dmenu

import XMonad.Actions.NoBorders

import XMonad.Layout.SimpleFloat
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances

myColor = "#df5714"
--myColor = "#5e6f50"
myModMask = mod4Mask            
myBorderWidth = 1              
myNormalBorderColor = "#1d2021" 
myFocusedBorderColor = myColor
myBrowser = "librewolf"
myTerminal = "alacritty"
-- myTerminal = "emacsclient -c -a emacs --eval '(multi-vterm)'"
myFM = "thunar"

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

myLayout = (tiled ||| Mirror tiled ||| Full)
  where										   
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

xmobar1 = statusBarProp "xmobar -x 0 $HOME/.config/xmonad/xmobar1.hs" (pure myXmobarPP)
xmobar2 = statusBarProp "xmobar -x 1 $HOME/.config/xmonad/xmobar2.hs" (pure myXmobarPP)
myXmobarPP :: PP						  
myXmobarPP =					 
  def					      
    { ppSep = wal " | ",					       
      ppTitleSanitize = xmobarStrip,			       
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#3bae4b" 2,
      ppHidden = white . wrap " " "",
      --  ppHiddenNoWindows = lowWhite . wrap " " "", -- IF YOU WANT ALL WORKSPACES ON THE BAR
      ppHiddenNoWindows = const "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused = wrap (white "[") (white "]") . wal . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . grey . ppWindow
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 10
    blue, lowWhite, magenta, red, white, yellow, wal, grey, green :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""
    grey = xmobarColor "#8e8e8e" ""
    green = xmobarColor "#8ba37d" "" 
    wal = xmobarColor myColor ""

quitWithWarning :: X ()
quitWithWarning = do
  let m = "confirm quit"
  s <- dmenu [m]
  when (m == s) (io exitSuccess)

main :: IO ()
main = do
  xmonad
    $ docks
    $ ewmh
    $ ewmhFullscreen
    $ withEasySB (xmobar1 <> xmobar2) defToggleStrutsKey
    $ defaults

defaults = def
  { modMask = myModMask
  , terminal = myTerminal
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , manageHook = myManageHook
  , handleEventHook = myHandleEventHook
  , layoutHook = myLayout
  } `additionalKeys`
  [ ((myModMask, xK_f), spawn myBrowser)
  -- , ((myModMask .|. shiftMask, xK_q), quitWithWarning)  -- NEEDS DMENU
  , ((myModMask, xK_q), spawn "xmonad --restart")
  , ((myModMask .|. shiftMask, xK_l), spawn "slock")
  , ((myModMask .|. shiftMask, xK_e), spawn "emacsclient -c -a emacs")
  -- , ((myModMask .|. shiftMask, xK_Return), spawn "emacsclient -c --eval '(vterm)'")
  , ((myModMask .|. shiftMask, xK_p), spawn "spotify")
  , ((myModMask, xK_p), spawn "bash /home/ame/.config/wal/dmen.sh")
  , ((myModMask .|. shiftMask, xK_d), spawn "discord")
  , ((myModMask .|. shiftMask, xK_s), spawn "maim -s /home/ame/Pictures/screenshots/$(date +%s)-screenshot.png && thunar ~/Pictures/screenshots/")
  , ((myModMask .|. shiftMask, xK_t), spawn myFM)
  , ((myModMask .|. shiftMask, xK_b), withFocused toggleBorder)
  , ((myModMask .|. shiftMask, xK_r), spawn "bash /home/ame/.config/screenlayout.sh")
  , ((0, xF86XK_AudioPlay) , spawn "playerctl -p spotify play-pause")
  , ((0, xF86XK_AudioPrev) , spawn "playerctl -p spotify previous")
  , ((0, xF86XK_AudioNext) , spawn "playerctl -p spotify next")
  ]
