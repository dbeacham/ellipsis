--imports
import XMonad
import Control.Monad
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook (withUrgencyHook, NoUrgencyHook(..))
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Actions.CycleWS (nextScreen, prevScreen, shiftNextScreen, shiftPrevScreen)

import System.IO

--definitions
myTerminal = "gnome-terminal"
myWorkspaces = [
  "1:main","2:mail","3:chat","4:web","5:browse","6:dev","7:audio", "8:ms", "9:trash"
  ]

myManageHook = composeAll . concat $
   [ [ className =? a --> viewShift "2:mail" | a <- myClassMailShifts ]
   , [ className =? a --> viewShift "4:web" | a <- myClassWebShifts ]
   , [ resource =? b --> doF (W.shift "3:chat") | b <- myClassChatShifts ]
   , [ className =? a --> viewShift "7:audio" | a <- myClassAudioShifts ]
   , [ className =? a --> viewShift "8:ms" | a <- myClassMSShifts ]
   , [ className =? a --> doF (W.shift "9:trash") | a <- myRebootShifts ]
   ]
  where viewShift = doF . liftM2 (.) W.view W.shift
        myClassMailShifts = ["Icedove", "Thunderbird"]
        myClassWebShifts = [ "Chromium", "Chromium-browser", "Iceweasel", "Firefox", "Google-chrome", "Google-chrome-unstable"
                           , "chromium", "chromium-browser", "iceweasel", "firefox", "google-chrome", "google-chrome-unstable"
                           ]
        myClassChatShifts = ["Pidgin", "Skype"]
        myClassAudioShifts = ["Gpodder", "Spotify"]
        myClassMSShifts = ["Remminna", "VirtualBox"]
        myRebootShifts = ["Zenity"]

main = do
    mapM_ spawnPipe
         [
           "xscreensaver"
         , "feh --bg-center $HOME/.xmonad/bg/haskell-pattern.png"
         --, "xloadimage -onroot -fullscreen $HOME/.xmonad/bg/haskell-pattern.png"
         -- , "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand false --width 10 --transparent true --tint 0x000 --height 12 --alpha 0 --padding 1"
         -- , "nm-applet --sm-disable"
         ]
    xmproc <- spawnPipe "/usr/bin/xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig {
        manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook    = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppUrgent = xmobarColor "#FF0000" ""
        , ppTitle  = xmobarColor "green" "" . shorten 50
        }
      , terminal    = myTerminal
      , workspaces  = myWorkspaces
      } `additionalKeysP` myKeys

myKeys = [ ("<XF86AudioRaiseVolume>", spawn "amixer set Master 2%+")
         , ("<XF86AudioLowerVolume>", spawn "amixer set Master 2%-")
         , ("M-C-l", spawn "xscreensaver-command -lock")
         , ("M-.", prevScreen)
         , ("M-,", nextScreen)
         , ("M-S-.", shiftPrevScreen)
         , ("M-S-,", shiftNextScreen)
         ]
