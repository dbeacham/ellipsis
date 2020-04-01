import           Control.Monad
import           Data.Default (def)

import           XMonad
import           XMonad.Config
import qualified XMonad.StackSet as W
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.UrgencyHook (withUrgencyHook, NoUrgencyHook(..))
import           XMonad.Util.Run(spawnPipe)
import           XMonad.Util.EZConfig (additionalKeysP)
import           XMonad.Actions.CycleWS (nextScreen, prevScreen, shiftNextScreen, shiftPrevScreen)

import System.IO

--definitions
myTerminal = "gnome-terminal --full-screen"
myWorkspaces = [
  "1:main","2:skype","3:chat","4:web","5:browse","6:dev","7:audio", "8:ms", "9:trash"
  ]

myManageHook = composeAll . concat $
   [ [ className =? a --> viewShift "2:skype" | a <- myClassMailShifts ]
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
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks $ withUrgencyHook NoUrgencyHook $ def {
        manageHook = manageDocks <+> myManageHook <+> manageHook def
      , layoutHook = avoidStruts $ layoutHook def
      , logHook    = dynamicLogWithPP xmobarPP
        { ppOutput = hPutStrLn xmproc
        , ppUrgent = xmobarColor "#FF0000" ""
        , ppTitle  = xmobarColor "green" "" . shorten 50
        }
      , terminal    = myTerminal
      , workspaces  = myWorkspaces
      , borderWidth = 1
      } `additionalKeysP` myKeys

myKeys = [ ("M-C-S-l", spawn "xscreensaver-command -lock")
         , ("M-.", prevScreen)
         , ("M-,", nextScreen)
         , ("M-S-.", shiftPrevScreen)
         , ("M-S-,", shiftNextScreen)
         ]
