Config { font         = "Terminus"
       , border       = BottomBM 4
       , borderColor  = "#5e6f50"
       , bgColor      = "black"
       , fgColor      = "grey"
       , position     = Top L 
       , lowerOnStart = True
       , commands     = [ Run Weather "KDFW" ["-t", "Richardson : <tempF>°", "-L", "50", "-H", "90", "--normal", "grey", "--high", "#5e6f50", "--low", "lightblue"] 36000
                        , Run Network "enp10s0f3u1u2" [ "-L", "0", "-H", "150", "--normal", "grey", "--high", "#5e6f50"] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Memory ["-t","Mem: <usedratio>%"] 50
                        , Run Date "%_A %D %r" "date" 10
			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run Com "/bin/bash" ["-c", "/home/ame/.config/xmonad/scripts/spotify.sh"] "playing" 10
                        , Run XMonadLog
                        ]
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ %playing% | %multicpu% | %memory% | %enp10s0f3u1u2% | %KDFW%F | <fc=#5e6f50>%date%</fc> "
       
}
