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
       , template     = "%XMonadLog% }{ | <fc=#3b56dc>%date%</fc> "
       , commands     = [ Run Date "%a %m/%d %I:%M" "date" 10
                        , Run XMonadLog
                        ]
}
