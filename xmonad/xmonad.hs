import XMonad

import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

import XMonad.Layout.NoBorders

myTerminal = "kitty"
myBrowser  = "firefox"

mylayoutHook = noBorders Full ||| noBorders tiled
  where
    tiled        = Tall nmaster delta ratio
    nmaster      = 1
    ratio        = 1/2
    delta        = 3/100

main :: IO ()
main = xmonad $ def 
  { terminal = myTerminal
  , layoutHook = mylayoutHook
  }
  `additionalKeysP`
    [ ("M-S-Enter"                , spawn myTerminal                    )
    , ("M-d"                      , spawn myBrowser                     )
    , ("M-S-q"                    , spawn "systemctl suspend"           )
    , ("<XF86MonBrightnessUp>"    , spawn "lux -a 5%"                   )
    , ("<XF86MonBrightnessDown>"  , spawn "lux -s 5%"                   )
    , ("<XF86AudioLowerVolume>"   , spawn "pactl set-sink-volume 0 -5%" )
    , ("<XF86AudioRaiseVolume>"   , spawn "pactl set-sink-volume 0 +5%" )
    , ("<XF86AudioMute>"          , spawn "pactl set-sink-mute-toggle"  )
    ]
