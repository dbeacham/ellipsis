Config {
    font     = "-*-Terminus-Medium-R-Normal-*-12-*-*-*-*-*-*-*"
  , bgColor  = "black"
  , fgColor  = "grey"
  , position = TopW L 95
  , commands = [
        Run MultiCpu
          [ "-t","Cpu: <total>%"
          , "-L","50"
          , "-H","80"
          , "-p","3"
          , "--low","green"
          , "--normal","orange"
          , "--high","red"
          ]
          10
      , Run Memory
          [ "-t","Mem: <usedratio>%"
          , "-L","50"
          , "-H","80"
          , "--low","green"
          , "--normal","orange"
          , "--high","red"
          ]
          10
      , Run Date "%a %b %_d %H:%M:%S" "date" 10
      , Run StdinReader
      , Run Battery
          [ "BAT0"
          , "-t", "AC: <acstatus> <watts>W | <left>% (<timeleft>)"
          , "-L", "10"
          , "-H", "40"
          , "--low", "red"
          , "--normal","orange"
          , "--high", "green"
          , "--"
          , "-O", "<fc=green>On</fc>"
          , "-o", "<fc=red>Off</fc>"
          ]
          10
      ]
  , sepChar = "%"
  , alignSep = "}{"
  , template = "%StdinReader% }{ %multicpu% | %memory% | %battery%   <fc=#ee9a00>%date%</fc> "
}
