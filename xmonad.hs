import Custom.Defaults
import Custom.XMobarPP
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar

main :: IO ()
main = do
  xmonad
    $ ewmh
    $ ewmhFullscreen
    $ withEasySB (xmobar1 <> xmobar2) defToggleStrutsKey
    $ defaults

