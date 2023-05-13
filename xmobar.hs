Config { font         = "Terminus"
       , border       = BottomBM 4
       , borderColor  = "#5e6f50"
       , bgColor      = "black"
       , fgColor      = "grey"
       , position     = Top L 
       , lowerOnStart = True
       , commands     = [ Run Network "enp10s0f3u1u2" [ "-L", "0", "-H", "150", "--normal", "grey", "--high", "#5e6f50"] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Memory ["-t","Mem: <usedratio>%"] 50
                        , Run Date "%a %m/%d %I:%M" "date" 10
			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/wttr.sh"] "Weather" 36000
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/spotify.sh"] "playing" 10
                        , Run XMonadLog
                        ]
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ %playing% | %multicpu% | %memory% | %enp10s0f3u1u2% | %Weather% | <fc=#5e6f50>%date%</fc> "
       
}
