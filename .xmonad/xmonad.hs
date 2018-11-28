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

myWorkSpaces = [ "web"   -- Workspace 1
	           , "dev"   -- Workspace 2
               , "ops"   -- Workspace 3
	           , "music" -- Workspace 4
	           ]

myStartupHook :: X ()
myStartupHook = do
    spawnOn "dev" "code";
    spawnOn "web" "google-chrome"
    spawnOn "dev" "slack"
    spawnOn "ops" "gnome-terminal"

main = do
    xmproc <- spawnPipe "/usr/bin/xmobar"
    xmonad $ defaultConfig
        { workspaces  = myWorkSpaces
	, startupHook = myStartupHook
 	, manageHook  = myManageHook <+> manageHook defaultConfig
        , layoutHook  = avoidStruts $ layoutHook defaultConfig
        , logHook     = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "" . shorten 50
            }
        , borderWidth = 2
        , terminal    = "urxvtc" } `additionalKeys`
        [ ((mod4Mask    ,xK_l), spawn "gnome-screensaver-command -l")
        ]
