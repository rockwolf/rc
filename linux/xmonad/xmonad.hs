----------------------------------------------------------------------------------------------------
-- xmonad config
-- Author: Andy Nagels
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- imports
----------------------------------------------------------------------------------------------------
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import System.IO
import XMonad.Actions.CycleWS
import XMonad.Layout.IndependentScreens -- for DWM like workspace/xinerama behaviour
import Xmonad.Layout.Fullscreen
import Xmonad.Layout.NoBorders
import Layout.Tabbed
import qualified XMonad.StackSet as W -- manageHook rules
import qualified Data.Map as M

----------------------------------------------------------------------------------------------------
-- terminal
----------------------------------------------------------------------------------------------------
myTerminal = "urxvtc"

----------------------------------------------------------------------------------------------------
-- workspaces
----------------------------------------------------------------------------------------------------
myWorkspaces :: [String]
myWorkspaces = withScreens 2 ["一","二","三","四","五","六","七","八","九","十"]

----------------------------------------------------------------------------------------------------
-- settings
----------------------------------------------------------------------------------------------------
myFont = "xft:inconsolata:pixelsize=18:antialias=true:hinting=true"
myModMask = mod4Mask
myNormalBorderColor = "#002b36"
myFocusedBorderColor = "#839496"

----------------------------------------------------------------------------------------------------
-- status bar
----------------------------------------------------------------------------------------------------
myXmobar = "/usr/bin/xmobar /home/rockwolf/.xmobarrc -f " ++ myFont
myXmobarColor = "#93a1a1"

----------------------------------------------------------------------------------------------------
-- window rules
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
----------------------------------------------------------------------------------------------------
myManageHook = composeAll
    [
    className =? "Gimp" --> doFloat
    , className =? "MPlayer" --> doFloat
    , className =? "Gimp" --> doF (W.shift (myWorkspaces !! 6))
    , className =? "firefox-bin" --> doF (W.shift (myWorkspaces !! 1))
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]

----------------------------------------------------------------------------------------------------
-- layouts
----------------------------------------------------------------------------------------------------
myLayout = avoidStruts (
    Tall 1 (3/100) (1/2) |||
    Mirror (Tall 1 (3/100) (1/2)) |||
    tabbed shrinkText tabConfig |||
    Full |||
    noBorders (fullscreenFull Full)

----------------------------------------------------------------------------------------------------
-- main
----------------------------------------------------------------------------------------------------
main = do
    xmproc <- spawnPipe myXmobar
    --var_screen_count <- countScreens
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
                    , ppTitle = xmobarColor myXmobarColor "" . shorten 50 
                }
            -- apps
            , terminal = myTerminal
            -- key bindings
            , modMask = myModMask
            -- layout
            , normalBorderColor = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
        } `additionalKeys`
        [ ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ] `additionalKeysP`
        --[ ("M-s-<Tab>", moveTo Prev NonEmptyWS)
        --  , ("M-<Tab>", moveTo Next NonEmptyWS)
        --]
        [ ("M-" ++ [key], action tag)
          | (tag, key)  <- zip myWorkspaces ""
          , (myModMask, action) <- [ ("", windows . W.view) -- was W.greedyView
                                        , ("S-", windows . W.shift)]
        ]
        --[((m .|. modm, k), windows $ onCurrentScreen f i)
        -- | (i, k) <- zip (workspaces') [xK_1 .. xK_9]
        -- , (f, m) <- [(W.View, 0), (W.shift, shiftMask)]]


