Config { font         = "Terminus"
       , textOffset   = 1
       , border       = BottomBM 1
       , borderColor  = "#5e6f50"
       , bgColor      = "#1d2021"
       , fgColor      = "grey"
       , position     = Top
       , lowerOnStart = True
       , commands     = [ Run DynNetwork [ "--template" , "<tx>kB/s | <rx>kB/s"
                                         , "--Low"      , "1000"       -- units: kB/s
                                         , "--High"     , "5000"       -- units: kB/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Memory ["-t","<used> Gb", "-d", "1", "--", "--scale", "1024"] 50
                        , Run Date "%I:%M" "date" 10
			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/wttr.sh"] "weather" 36000
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/spotify.sh"] "playing" 10
                        , Run XMonadLog
                        ]
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ %playing% | %multicpu% | %memory% | %dynnetwork% | %weather% | <fc=#5e6f50>%date%</fc> "
       
}
