import System.Exit
import Control.Monad

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

myStartupHook :: X ()                                                                                                                         
myStartupHook = do                                                                                                                            
  spawnOnce "nitrogen --restore &"                                                                                            
  spawnOnce "wal -R &"

myTerm = "kitty"                
myModMask = mod4Mask            
myBorderWidth = 3               
myNormalBorderColor = "#222222" 
myFocusedBorderColor = "#DE5e5e"

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
    { ppSep = walred " | ",                                                                                                                   
      ppTitleSanitize = xmobarStrip,                                                                                                          
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,                                                                               
      ppHidden = white . wrap " " "",                                                                                                         
      ppHiddenNoWindows = lowWhite . wrap " " "",                                                                                             
      ppUrgent = red . wrap (yellow "!") (yellow "!"),                                                                                        
      ppOrder = \[ws, l, _, wins] -> [ws, l, wins],                                                                                           
      ppExtras = [logTitles formatFocused formatUnfocused]                                                                                    
    }                                                                                                                                         
  where                                                                                                                                       
    formatFocused = wrap (white "[") (white "]") . walred . ppWindow                                                                          
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . grey . ppWindow                                                                    
    ppWindow :: String -> String                                                                                                              
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30                                                              
                                                                                                                                              
    blue, lowWhite, magenta, red, white, yellow, walred, grey :: String -> String                                                             
    magenta = xmobarColor "#ff79c6" ""                                                                                                        
    blue = xmobarColor "#bd93f9" ""                                                                                                           
    white = xmobarColor "#f8f8f2" ""                                                                                                          
    yellow = xmobarColor "#f1fa8c" ""                                                                                                         
    red = xmobarColor "#ff5555" ""                                                                                                            
    lowWhite = xmobarColor "#bbbbbb" ""                                                                                                       
    grey = xmobarColor "#8e8e8e" ""                                                                                                           
    walred = xmobarColor "#de5e5e" ""

quitWithWarning :: X ()
quitWithWarning = do
  let m = "confirm quit"
  s <- dmenu [m]
  when (m == s) (io exitSuccess)

main :: IO ()
main = do
  xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmonad/xmobar/xmobar.hs"
  xmproc1 <- spawnPipe "xmobar -x 1 $HOME/.config/xmonad/xmobar/xmobar.hs"
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
  } `additionalKeysP`
  [ ("M-f", spawn "firefox")
  , ("M-S-q", quitWithWarning)
  , ("M-S-l", spawn "slock")
  , ("M-S-e", spawn "emacsclient -c")
  , ("M-S-p", spawn "spotify")
  , ("M-S-s", spawn "maim -s /home/ame/screenshots.png")
  , ("M-S-v", spawn "code")
  , ("M-S-t", spawn "thunar")
  ]
