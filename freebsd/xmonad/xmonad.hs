import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
 
 
--||| Theme configuration
-- | Colors
colorBlack, colorDarkGray, colorLightGray, colorRed, colorCyan, colorWhite :: [Char]
--TODO: better color values
colorBlack           = "#000000"
colorDarkGray        = "#222222"
colorLightGray       = "#aaaaaa"
colorLightBlue       = "#0066ff"
colorWhite           = "#ffffff"
colorRed             = "#ff0000"
colorCyan            = "#00ffff"
colorMagenta         = "#ff00fd"
colorBlue            = "#003cfd"
colorGreen           = "#00ff00"
colorYellow          = "#fdfd00"
-- | Fonts 
barFont, barXFont    :: [Char]
barFont              = "terminus"
barXFont             = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*"
-- | Workspaces
myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
 
-- ||| Floating windows
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "MPlayer"   --> doFloat
    ]

-- ||| Main 
main = do
    xmproc <- spawnPipe "xmobar $HOME/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { borderWidth = 2
        , workSpaces = withScreens nScreens(map show myWorkSpaces),
        , terminal = "urxvtc -e tmux -2 -new-session"
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        -- TODO: doesn't the mod4Mask below, need to be modMask?
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "slock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
