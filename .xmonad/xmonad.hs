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

myWorkSpaces = [ "slack"    -- Workspace 1
	       , "web"      -- Workspace 2
               , "code"     -- Workspace 3
	       , "terminal" -- Workspace 4
               , "mail"     -- Workspace 5
               , "sites"    -- Workspace 6
	       ]

myStartupHook :: X ()
myStartupHook = do
    spawnOn "slack"    "slack";
    spawnOn "web"      "google-chrome"
    spawnOn "code"     "code"
    spawnOn "terminal" "gnome-terminal"
    spawnOn "sites"    "/opt/Local/local"
    spawnOn "mail"     "thunderbird"

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
