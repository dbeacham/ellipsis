--imports
import XMonad
import Control.Monad
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeysP)
import System.IO

--definitions
myTerminal = "gnome-terminal"
myWorkspaces = [
  "1:main","2:mail","3:chat","4:web","5:browse","6:dev","7:audio"
  ]

myManageHook = composeAll . concat $
   [ [ className =? a --> viewShift "2:mail" | a <- myClassMailShifts ]
   , [ className =? a --> viewShift "4:web" | a <- myClassWebShifts ]
   , [ resource =? b --> doF (W.shift "3:chat") | b <- myClassChatShifts ]
   , [ className =? a --> viewShift "7:audio" | a <- myClassAudioShifts ]
   ]
  where viewShift = doF . liftM2 (.) W.greedyView W.shift
        myClassMailShifts = ["Icedove", "Thunderbird"]
        myClassWebShifts = ["Chromium", "Chromium-browser", "Iceweasel", "Firefox"]
        myClassChatShifts = ["Pidgin", "Skype"]
        myClassAudioShifts = ["GPodder", "Spotify"]

main = do
    mapM spawnPipe
         [
           "xscreensaver"
         , "feh --bg-center $HOME/.xmonad/bg/haskell-pattern.png"
         ]
    xmproc <- spawnPipe "/usr/bin/xmobar"
    xmonad $ defaultConfig {
        manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook    = dynamicLogWithPP xmobarPP {
          ppOutput = hPutStrLn xmproc
        , ppTitle  = xmobarColor "green" "" . shorten 50
        }
      , terminal    = myTerminal
      , workspaces  = myWorkspaces
      } `additionalKeysP` myKeys

myKeys = [ ("<XF86AudioRaiseVolume>", spawn "amixer set Master 2%+")
         , ("<XF86AudioLowerVolume>", spawn "amixer set Master 2%-")
         , ("M-S-l", spawn "xscreensaver-command -lock")
         ]
