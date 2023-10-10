module Custom.XMobarPP where

import Custom.Variables
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Hooks.StatusBar

xmobar1 = statusBarProp "xmobar -x 0 $HOME/.config/xmonad/xmobar1.hs" (pure myXMobarPP)
xmobar2 = statusBarProp "xmobar -x 1 $HOME/.config/xmonad/xmobar2.hs" (pure myXMobarPP)

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
