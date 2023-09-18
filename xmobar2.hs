Config { font         = "Terminus"
       , textOffset   = 1
       , border       = BottomBM 1
       , borderColor  = "#6e18cc"
       , bgColor      = "#0f0f0f"
       , fgColor      = "grey"
       , position     = TopH 23
       , lowerOnStart = True
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ %playing% | %multicpu% | RAM: %memory% | %dynnetwork% | %KDFW% | <fc=#6e18cc>%date%</fc> "
       , commands     = [ Run DynNetwork [ "--template" , "Up: <tx>kB/s | Down: <rx>kB/s"
                                         , "--Low"      , "1000"       -- units: kB/s
                                         , "--High"     , "5000"       -- units: kB/s
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Weather "KDFW" ["-t", "<skyCondition> <tempF> deg.", "-L", "50", "-H", "90", "--normal", "grey", "--high", "#de5e5e", "--low", "lightblue"] 36000
                        , Run Memory ["-t","<used> Gb", "-d", "1", "--", "--scale", "1024"] 50
                        , Run Date "%I:%M" "date" 10
            			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/scripts/spotify.sh"] "playing" 10
--			            , Run Com "/bin/bash" ["-c", "/home/ame/.config/scripts/packages.sh"] "packages" 1000
                        , Run XMonadLog
                        ]

       
}
