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

myStartupHook :: X ()
myStartupHook = do
  spawnOnce "bash ~/.config/screenlayout.sh"
  -- spawnOnce "picom -b"
  spawnOnce "wal -R &"
  --spawnOnce "nitrogen --restore &"

myColor = "#5e6f50"
myTerm = "kitty"                
myModMask = mod4Mask            
myBorderWidth = 3               
myNormalBorderColor = "#222222" 
myFocusedBorderColor = myColor

myManageHook :: ManageHook                                                                                                                    
myManageHook =                                                                                                                                
  composeAll                                                                                                                                  
    [ className =? "Gimp" --> doFloat,                                                                                                        
      isDialog --> doFloat                                                                                                                    
    ]

myLayout = (tiled ||| Mirror tiled ||| Full)
  where                                                                                  
    tiled = Tall nmaster delta ratio
    nmaster = 1
    ratio = 1 / 2
    delta = 3 / 100

myXmobarPP :: PP                                                                                                                              
myXmobarPP =                                                                                                                                  
  def                                                                                                                                         
    { ppSep = green " | ",                                                                                                                   
      ppTitleSanitize = xmobarStrip,                                                                                                          
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,                                                                               
      ppHidden = white . wrap " " "",                                                                                                         
      ppHiddenNoWindows = lowWhite . wrap " " "",                                                                                             
      ppUrgent = red . wrap (yellow "!") (yellow "!"),                                                                                        
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],                                                                                           
      ppExtras = [logTitles formatFocused formatUnfocused]                                                                                    
    }                                                                                                                                         
  where                                                                                                                                       
    formatFocused = wrap (white "[") (white "]") . green . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . grey . ppWindow                                                                    
    ppWindow :: String -> String                                                                                                              
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30                                                              

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
  xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmonad/xmobar.hs"
  xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmonad/xmobar.hs"
  xmonad
    $ docks
    $ ewmh
    $ ewmhFullscreen
    $ withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobar/xmobar.hs" (pure myXmobarPP)) defToggleStrutsKey
    $ defaults

defaults = def
  { terminal = myTerm
  , modMask = myModMask
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , manageHook = myManageHook
  , layoutHook = myLayout
  , startupHook = myStartupHook
  } `additionalKeys`
  [ ((myModMask, xK_f), spawn "firefox")
  , ((myModMask .|. shiftMask, xK_q), quitWithWarning)
  , ((myModMask .|. shiftMask, xK_l), spawn "slock")
  , ((myModMask .|. shiftMask, xK_e), spawn "emacsclient -c")
  , ((myModMask .|. shiftMask, xK_p), spawn "spotify")
  , ((myModMask .|. shiftMask, xK_s), spawn "maim -s /home/ame/screenshots.png")
  , ((myModMask .|. shiftMask, xK_v), spawn "code")
  , ((myModMask .|. shiftMask, xK_t), spawn "nemo")
  , ((myModMask .|. shiftMask, xK_b), withFocused toggleBorder)
  , ((0, xF86XK_AudioPlay) , spawn "playerctl play-pause")
  , ((0, xF86XK_AudioPrev) , spawn "playerctl previous")
  , ((0, xF86XK_AudioNext) , spawn "playerctl next")
  ]
