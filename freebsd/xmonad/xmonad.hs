import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.Layout.IndependentScreens
 
 
-- ||| Theme configuration
-- | Colors (solarized color scheme)
colorBlack, colorBrBlack      :: [Char]
colorWhite, colorBrWhite      :: [Char]
colorYellow, colorBrYellow    :: [Char]
colorGreen, colorBrGreen      :: [Char]
colorBlue, colorBrBlue        :: [Char]
colorRed, colorBrRed          :: [Char]
colorCyan, colorBrCyan        :: [Char]
colorMagenta, colorBrMagenta  :: [Char]
colorBlack           = "#002b36"
colorBrBlack         = "#073642"
colorWhite           = "#eee8d5"
colorBrWhite         = "#fdf6e3"
colorYellow          = "#b58900"
colorBrYellow        = "#657b83"
colorGreen           = "#859900"
colorBrGreen         = "#586e75"
colorBlue            = "#268bd2"
colorBrBlue          = "#839496"
colorRed             = "#dc322f"
colorBrRed           = "#cb4b16"
colorCyan            = "#2aa198"
colorBrCyan          = "#93a1a1"
colorMagenta         = "#d33682"
colorBrMagenta       = "#6c71c4"

-- | Fonts 
barFont, barXFont    :: [Char]
barFont              = "terminus"
barXFont             = "-*-terminus-medium-r-*-*-12-*-*-*-*-*-*-*"
-- | Workspaces
myWorkSpaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
-- | Applications
myTerminal = "urxvtc -e tmux -2 -new-session"
myScreenSaver = "slock"
myScrot = "scrot"
myScrotSelection = "sleep 0.2; scrot -s"
myXmobar = "xmobar $HOME/.xmonad/xmobarrc"
 
-- ||| Floating windows
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "MPlayer"   --> doFloat
    ]

-- ||| Main 
main = do
    xmproc <- spawnPipe myXmobar
    xmonad $ defaultConfig
        { borderWidth = 2
        , workSpaces = withScreens nScreens(map show myWorkSpaces),
        , terminal = myTerminal
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
        [ ((mod4Mask .|. shiftMask           , xK_z        ), spawn myScreenSaver)
        , ((controlMask                      , xK_Print    ), spawn myScrotSelection)
        , ((0                                , xK_Print    ), spawn myScrot)
        , ((mod4Mask                         , xK_comma    ), withScreen 0 view)
        , ((mod4Mask .|.                     , xK_comma    ), withScreen 0 viewShift)
        , ((mod4Mask                         , xK_period   ), withScreen 1 view)
        , ((mod4Mask .|.                     , xK_period   ), withScreen 1 viewShift)
        , ((mod4Mask                         , xK_slash    ), withScreen 2 view)
        , ((mod4Mask .|.                     , xK_slash    ), withScreen 2 viewShift)
        ]
