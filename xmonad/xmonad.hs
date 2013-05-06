import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import System.IO
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W -- manageHook rules

terminal' = "urxvtc"

font' = "xft:inconsolata:pixelsize=18:antialias=true:hinting=true"

xmobar' = "/usr/bin/xmobar /home/rockwolf/.xmobarrc -f " ++ font'

main = do
    xmproc <- spawnPipe xmobar'
    xmonad $ defaultConfig
        {
            -- workspaces
            workspaces = myWorkspaces
            -- status bar and dock
            , manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
            , layoutHook = avoidStruts $ layoutHook defaultConfig
            , logHook = dynamicLogWithPP xmobarPP
                {
                    ppOutput = hPutStrLn xmproc
                    , ppTitle = xmobarColor "#93a1a1" "" . shorten 50 
                }
            -- apps
            , terminal = terminal'
            -- key bindings
            , modMask = mod4Mask
            -- layout
            , normalBorderColor = "#002b36"
            , focusedBorderColor = "#839496"
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ] `additionalKeysP`
        [ ("M-s-<Tab>", moveTo Prev NonEmptyWS)
        , ("M-<Tab>", moveTo Next NonEmptyWS)
        ]

myWorkspaces :: [String]
myWorkspaces = ["一","二","三","四","五","六","七","八","九","十"]

myManageHook = composeAll
    [
        className =? "Gimp" --> doFloat
        , className =? "MPlayer" --> doFloat
        , className =? "Gimp" --> doF (W.shift (myWorkspaces !! 6))
        , className =? "firefox" --> doF (W.shift (myWorkspaces !! 1))
    ]
