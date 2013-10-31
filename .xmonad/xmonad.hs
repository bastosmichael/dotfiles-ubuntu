import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Actions.SpawnOn
import System.IO

myManageHook  = composeAll
	[ className =? "emulator" --> doFloat
	, manageDocks
	]

myWorkSpaces = [ "web" -- Workspace 1
	       , "dev" -- Workspace 2
	       ]

myStartupHook :: X ()
myStartupHook = do
	spawnOn "web" "google-chrome"

main = do
    xmonad =<< xmobar defaultConfig
        { XMonad.workspaces  = myWorkSpaces 
	, XMonad.manageHook  = myManageHook <+> manageHook defaultConfig
        , XMonad.layoutHook  = avoidStruts $ layoutHook defaultConfig
        , XMonad.borderWidth = 2
        , XMonad.terminal    = "urxvtc"
	, XMonad.startupHook = myStartupHook
	}
