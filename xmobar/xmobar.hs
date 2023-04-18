Config { font         = "Terminus"
       , border       = BottomBM 4
       , borderColor  = "#DE5E5E"
       , bgColor      = "black"
       , fgColor      = "grey"
       , position     = Top L 
       , lowerOnStart = True
       , commands     = [ Run Weather "KDFW" ["-t", "Richardson : <tempF>°", "-L", "50", "-H", "90", "--normal", "grey", "--high", "#de5e5e", "--low", "lightblue"] 36000
                        , Run Network "enp10s0f3u1u2" [ "-L", "0", "-H", "150", "--normal", "grey", "--high", "#de5e5e"] 10
                        , Run MultiCpu ["autosystem", "autobar"] 50
                        , Run Memory ["-t","Mem: <usedratio>%"] 50
                        , Run Date "%_A %D %r" "date" 10
			, Run Alsa "default" "Master" [ "--template", "<volumestatus>", "--suffix", "True", "--", "--on", "" ]
                        , Run XMonadLog
                        ]
       , sepChar      = "%"
       , alignSep     = "}{"
       , template     = "%XMonadLog% }{ %multicpu% | %memory% | %enp10s0f3u1u2% | %KDFW%F | <fc=#DE5E5E>%date%</fc> "
       }
