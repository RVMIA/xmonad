Config { font         = "Terminus"
       , textOffset   = 1
       , border       = BottomBM 1
       , borderColor  = "#5377b5"
       , bgColor      = "#1d2432"
       , fgColor      = "grey"
       , position     = TopH 23
       , lowerOnStart = True
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ | <fc=#5377b5>%date%</fc> "
       , commands     = [ Run DynNetwork [ "--template" , "<tx>kB/s | <rx>kB/s"
                                         , "--Low"      , "1000"       -- units: kB/s
                                         , "--High"     , "5000"       -- units: kB/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Memory ["-t","<used> Gb", "-d", "1", "--", "--scale", "1024"] 50
                        , Run Date "%a %m/%d %I:%M" "date" 10
			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/wttr.sh"] "weather" 36000
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/spotify.sh"] "playing" 10
                        , Run XMonadLog
                        ]
}
