import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.Drawer
import XMonad.Layout.LayoutModifier
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce

myTerm :: String
myTerm = "alacritty"

myScreenResize :: String
myScreenResize = unwords ["xrandr"
                        ,"--output DisplayPort-0 --primary"
                          ,"--mode 1920x1080"
                          ,"--pos 1920x0"
                          ,"--rotate normal"
                        ,"--output HDMI-A-0"
                          ,"--mode 1920x1080"
                          ,"--pos 0x0"
                          ,"--rotate normal"
                        ,"&"]

myFM :: String
myFM = "thunar"

mySS :: String
mySS = concat ["maim -s", " ", ssDir, filename, " ", "&&", " ", myFM, " ", ssDir]
  where
    ssDir = "/home/ame/Pictures/screenshots/"
    filename = "$(date +%s)-screenshot.png"

myColor :: String
myColor = "#df5714"

myNormalBorderColor :: String
myNormalBorderColor = "#1d2021"

myFocusedBorderColor :: String
myFocusedBorderColor = myColor

myBorderWidth :: Dimension
myBorderWidth = 4

mM :: KeyMask
mM = mod4Mask

-- Startup the window Manager
myStartupHook :: X ()
myStartupHook = do
  spawnOnce myScreenResize
  spawnOnce "nitrogen --restore &"
  spawnOnce "setxkbmap -option caps:escape &"
  spawnOnce "dunst &"
  spawnOnce "pulseaudio &"

main :: IO ()
main = xmonad . ewmh . ewmhFullscreen . withEasySB (xmobar1 <> xmobar2) defToggleStrutsKey $ defaults

myKeys :: [((KeyMask, KeySym), X ())]
myKeys =
  [ ((mM, xK_f), spawn "firefox")
  , ((mM .|. shiftMask, xK_f), spawn "google-chrome-stable")
  , ((mM, xK_q), spawn "xmonad --restart")
  , ((mM .|. shiftMask, xK_l), spawn "slock")
  , ((mM .|. shiftMask, xK_p), spawn "spotify")
  , ((mM, xK_p), spawn "dmenu_run")
  , ((mM .|. shiftMask, xK_d), spawn "discord")
  , ((mM .|. shiftMask, xK_s), spawn mySS)
  , ((mM .|. shiftMask, xK_t), spawn myFM)
  , ((mM .|. shiftMask, xK_b), withFocused toggleBorder)
  , ((mM .|. shiftMask, xK_r), spawn myScreenResize)
  , ((0, xF86XK_AudioPlay) , spawn "playerctl -p spotify play-pause")
  , ((0, xF86XK_AudioPrev) , spawn "playerctl -p spotify previous")
  , ((0, xF86XK_AudioNext) , spawn "playerctl -p spotify next")
  ]



defaults = def
  { modMask = mM
  , terminal = myTerm 
  , borderWidth = myBorderWidth
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  -- , focusFollowsMouse = False
  , startupHook = myStartupHook
  , manageHook = myManageHook
  , layoutHook = (lessBorders Screen $ myLayout) 
  } `additionalKeys` myKeys



myLayout = tiled ||| Mirror tiled ||| Full 

tiled =  renamed [Replace "Tall"]
         $ smartSpacingWithEdge 10
         $ Tall nmaster delta ratio
  where nmaster = 1
        ratio = 1 / 2
        delta = 3 / 100



myHandleEventHook = swallowEventHook (className =? "Kitty" <||> className =? "Alacritty") (return True)

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat,
      isDialog --> doFloat,
      className =? "Spotify" --> doShift "9",
      className =? "discord" --> doShift "9"
    ]




xmobar1 = statusBarProp "xmobar -x 0 $HOME/.config/xmonad/xmobar.hs" (pure myXMobarPP)
xmobar2 = statusBarProp "xmobar -x 1 $HOME/.config/xmonad/xmobar.hs" (pure myXMobarPP)

myXMobarPP :: PP
myXMobarPP =
  def
    { ppSep = wal " | ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#3bae4b" 2,
      ppHidden = white . wrap " " "",
       -- ppHiddenNoWindows = lowWhite . wrap " " "", -- IF YOU WANT ALL WORKSPACES ON THE BAR
      ppHiddenNoWindows = const "", -- OR ONLY SHOW POPULATED WORKSPACES
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
