import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import XMonad.StackSet as W hiding (workspaces)
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import Data.Maybe
import Data.Ratio
import Data.Bits ((.|.))
import Data.Monoid
import Data.Map as M hiding (map, keys)
import GHC.Real -- for the :% operator
import XMonad.Actions.SpawnOn
import System.Exit
 
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
myTerminal = "urxvtc -e tmux -2 new-session"
myScreenSaver = "slock"
myScrot = "scrot"
myScrotSelection = "sleep 0.2; scrot -s"
myXmobar = "xmobar $HOME/.xmonad/xmobarrc"
 
-- ||| Floating windows
myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "MPlayer"   --> doFloat
    ]

-- | Fullscreen MPlayer
fullscreenMPlayer = className =? "MPlayer" --> do
    dpy   <- liftX $ asks display
    win   <- ask
    hints <- liftIO $ getWMNormalHints dpy win
    case fmap (approx . fst) (sh_aspect hints) of
        Just ( 4 :% 3)  -> viewFullOn win 0 "1"
        Just (16 :% 9)  -> viewFullOn win 1 "5"
        _               -> doFloat
    where
    fi               = fromIntegral
    approx (n, d)    = approxRational (fi n / fi d) (1/100)
    viewFullOn w s n = do
        let ws = marshall s n
        liftX  $ withScreen s view
        return . Endo $ view ws . shiftWin ws w

-- | Screen functions
withScreen screen f = screenWorkspace screen >>= flip whenJust (windows . f)
viewShift  i = view i . shift i

-- | Keybindings
myKeys conf = let m = modMask conf in M.fromList $ 
    [ ((m .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((m,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- %! Launch dmenu
    , ((m .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((m .|. shiftMask, xK_c     ), kill) -- %! Close the focused window

    , ((m,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((m .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((m,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((m,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((m .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((m,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((m,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((m,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((m,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((m .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((m .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((m,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((m,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((m,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((m              , xK_bracketleft ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((m              , xK_bracketright), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- toggle the status bar gap
    --, ((m              , xK_b     ), modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i in if n == x then (0,0,0,0) else x)) -- %! Toggle the status bar gap

    -- quit, or restart
    , ((m .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((m              , xK_q     ), spawn "xmonad --recompile && xmonad --restart") -- %! Restart xmonad
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((x .|. m, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, x) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- My own keys
    [
      ((m .|. shiftMask           , xK_z           ), spawn myScreenSaver)
    , ((controlMask               , xK_Print       ), spawn myScrotSelection)
    , ((0                         , xK_Print       ), spawn myScrot)
    , ((m                         , xK_comma       ), withScreen 0 view)
    , ((m .|. shiftMask           , xK_comma       ), withScreen 0 viewShift)
    , ((m                         , xK_period      ), withScreen 1 view)
    , ((m .|. shiftMask           , xK_period      ), withScreen 1 viewShift)
    , ((m                         , xK_slash       ), withScreen 2 view)
    , ((m .|. shiftMask           , xK_slash       ), withScreen 2 viewShift)
    ]
    ++
    [
      ((m                          , xK_1           ), windows (onCurrentScreen view 1))
    , ((m                          , xK_2           ), windows (onCurrentScreen view 2))
    , ((m                          , xK_3           ), windows (onCurrentScreen view 3))
    --, ((m                          , xK_4           ), windows (onCurrentScreen f workspace))
    --, ((m                          , xK_5           ), windows (onCurrentScreen f workspace))
    --, ((m                          , xK_6           ), windows (onCurrentScreen f workspace))
    --, ((m                          , xK_7           ), windows (onCurrentScreen f workspace))
    --, ((m                          , xK_8           ), windows (onCurrentScreen f workspace))
    --, ((m                          , xK_9           ), windows (onCurrentScreen f workspace))
    , ((m .|. shiftMask            , xK_1           ), windows (onCurrentScreen viewShift 1))
    , ((m .|. shiftMask            , xK_2           ), windows (onCurrentScreen viewShift 2))
    , ((m .|. shiftMask            , xK_3           ), windows (onCurrentScreen viewShift 3))
    ]
    {-- ++ 
    [((m    , key           ), windows (onCurrentScreen f workspace))
        | (key, workspace) <- zip [xK_1..xK_9] (workspaces' conf)
        , (e, f)           <- [(0, view), (shiftMask, viewShift)]
        , i                <- [0, controlMask, mod1Mask, controlMask .|. mod1Mask]]
    --}

--keyBindings =  
--myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
--myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
--    -- launching and killing programs
--    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
--    , ((modMask,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- %! Launch dmenu
--    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
--    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused window
--
--    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
--    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default
--
--    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size
--
--    -- move focus up or down the window stack
--    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
--    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
--    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
--    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
--    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window
--
--    -- modifying the window order
--    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
--    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
--    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window
--
--    -- resizing the master/slave ratio
--    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
--    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area
--
--    -- floating layer support
--    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling
--
--    -- increase or decrease number of windows in the master area
--    , ((modMask              , xK_bracketleft ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
--    , ((modMask              , xK_bracketright), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area
--
--    -- toggle the status bar gap
--    --, ((modMask              , xK_b     ), modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i in if n == x then (0,0,0,0) else x)) -- %! Toggle the status bar gap
--
--    -- quit, or restart
--    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
--    , ((modMask              , xK_q     ), spawn "xmonad --recompile && xmonad --restart") -- %! Restart xmonad
--    ]
--    ++
--    -- mod-[1..9] %! Switch to workspace N
--    -- mod-shift-[1..9] %! Move client to workspace N
--    [((m .|. modMask, k), windows $ f i)
--        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
--        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--    ++
--    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
--    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
--    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
--        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
--        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
--    {--++ 
--    [((modMask    , key           ), windows (onCurrentScreen f workspace))
--        | (key, workspace) <- zip [xK_1..xK_9] (workspaces' conf)
--        , (e, f)           <- [(0, view), (shiftMask, viewShift)]
--        , i                <- [0, controlMask, mod1Mask, controlMask .|. mod1Mask]]
--    --}
--   {-- ++
--    [ ((m, k), windows $ onCurrentScreen f i)
--      | (i, k) <- zip (workspaces' conf) [xK_1 .. xK_9]
--      , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
--    --}

-- ||| Main 
main = do
    nScreens <- countScreens
    xmproc <- spawnPipe myXmobar
    xmonad $ defaultConfig
        { borderWidth = 2
        , workspaces = withScreens nScreens (map show myWorkSpaces)
        , terminal = myTerminal
        , manageHook = manageDocks <+> myManageHook -- make sure to include myManageHook definition from above
                        <+> manageHook defaultConfig
                        <+> (isFullscreen --> doFullFloat)
                        <+> fullscreenMPlayer
                        <+> manageDocks
                        <+> manageSpawn
        , layoutHook = avoidStruts  $  layoutHook defaultConfig ||| noBorders Full
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask     -- Rebind Mod to the Windows key
        , keys = myKeys
        }
