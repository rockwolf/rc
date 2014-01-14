/* see LICENSE for copyright and license */

#ifndef CONFIG_H
#define CONFIG_H

/** modifiers **/
#define MOD1            Mod1Mask    /* ALT key */
#define MOD4            Mod4Mask    /* Super/Windows key */
#define CONTROL         ControlMask /* Control key */
#define SHIFT           ShiftMask   /* Shift key */

/** generic settings **/
#define MASTER_SIZE     0.52
#define SHOW_PANEL      True      /* show panel by default on exec */
#define TOP_PANEL       True      /* False means panel is on bottom */
#define PANEL_HEIGHT    18        /* 0 for no space for panel, thus no panel */
#define DEFAULT_MODE    TILE      /* initial layout/mode: TILE MONOCLE BSTACK GRID FLOAT */
#define ATTACH_ASIDE    True      /* False means new window is master */
#define FOLLOW_WINDOW   False     /* follow the window when moved to a different desktop */
#define FOLLOW_MONITOR  False     /* follow the window when moved to a different monitor */
#define FOLLOW_MOUSE    False     /* focus the window the mouse just entered */
#define CLICK_TO_FOCUS  True      /* focus an unfocused window when clicked  */
#define FOCUS_BUTTON    Button1   /* mouse button to be used along with CLICK_TO_FOCUS */
#define BORDER_WIDTH    2         /* window border width */
#define FOCUS           "#ffffd7" /* focused window border color   */
#define UNFOCUS         "#626262" /* unfocused window border color */
#define INFOCUS         "#5f8700" /* focused window border color on unfocused monitor */
#define MINWSZ          50        /* minimum window size in pixels */
#define DEFAULT_MONITOR 0         /* the monitor to focus initially */
#define DEFAULT_DESKTOP 0         /* the desktop to focus initially */
#define DESKTOPS        4         /* number of desktops - edit DESKTOPCHANGE keys to suit */

/**
 * open applications to specified monitor and desktop
 * with the specified properties.
 * if monitor is negative, then current is assumed
 * if desktop is negative, then current is assumed
 */
static const AppRule rules[] = { \
    /*  class     monitor  desktop  follow  float */
    { "MPlayer",     0,       3,    True,   False },
    { "Gimp",        0,       3,    False,  True  },
};

/* helper for spawning shell commands */
#define SHCMD(cmd) {.com = (const char*[]){"/bin/sh", "-c", cmd, NULL}}

/**
 * custom commands
 * must always end with ', NULL };'
 */
static const char font[]            = "Inconsolata 14";
static const char normbgcolor[]     = "#002b36";
static const char normfgcolor[]     = "#fdf6e3";
static const char selbgcolor[]      = "#002b36";
static const char selfgcolor[]      = "#fdf6e3";
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[] = { "urxvtc", NULL };

#define MONITORCHANGE(K,N) \
    {  MOD4,             K,              change_monitor, {.i = N}}, \
    {  MOD4|ShiftMask,   K,              client_to_monitor, {.i = N}},

#define DESKTOPCHANGE(K,N) \
    {  MOD4,             K,              change_desktop, {.i = N}}, \
    {  MOD4|ShiftMask,   K,              client_to_desktop, {.i = N}},

/**
 * keyboard shortcuts
 */
static Key keys[] = {
    /* modifier          key            function           argument */
    {  MOD4,             XK_b,          togglepanel,       {NULL}},
    {  MOD4,             XK_BackSpace,  focusurgent,       {NULL}},
    {  MOD4|SHIFT,       XK_c,          killclient,        {NULL}},
    {  MOD4,             XK_j,          next_win,          {NULL}},
    {  MOD4,             XK_k,          prev_win,          {NULL}},
    {  MOD4,             XK_h,          resize_master,     {.i = -10}}, /* decrease size in px */
    {  MOD4,             XK_l,          resize_master,     {.i = +10}}, /* increase size in px */
    {  MOD4,             XK_o,          resize_stack,      {.i = -10}}, /* shrink   size in px */
    {  MOD4,             XK_a,          resize_stack,      {.i = +10}}, /* grow     size in px */
    {  MOD4|CONTROL,     XK_h,          rotate,            {.i = -1}},
    {  MOD4|CONTROL,     XK_l,          rotate,            {.i = +1}},
    {  MOD4|SHIFT,       XK_h,          rotate_filled,     {.i = -1}},
    {  MOD4|SHIFT,       XK_l,          rotate_filled,     {.i = +1}},
    {  MOD4,             XK_Tab,        last_desktop,      {NULL}},
    {  MOD4,             XK_Return,     swap_master,       {NULL}},
    {  MOD4|SHIFT,       XK_j,          move_down,         {NULL}},
    {  MOD4|SHIFT,       XK_k,          move_up,           {NULL}},
    {  MOD4|SHIFT,       XK_t,          switch_mode,       {.i = TILE}},
    {  MOD4|SHIFT,       XK_m,          switch_mode,       {.i = MONOCLE}},
    {  MOD4|SHIFT,       XK_b,          switch_mode,       {.i = BSTACK}},
    {  MOD4|SHIFT,       XK_g,          switch_mode,       {.i = GRID}},
    {  MOD4|SHIFT,       XK_f,          switch_mode,       {.i = FLOAT}},
    {  MOD4|CONTROL,     XK_r,          quit,              {.i = 0}}, /* quit with exit value 0 */
    {  MOD4|CONTROL,     XK_q,          quit,              {.i = 1}}, /* quit with exit value 1 */
    {  MOD4|SHIFT,       XK_Return,     spawn,             {.com = termcmd}},
    {  MOD4,             XK_p,          spawn,             {.com = dmenucmd}},
    {  MOD4|MOD1,             XK_j,          moveresize,        {.v = (int []){   0,  25,   0,   0 }}}, /* move down  */
    {  MOD4|MOD1,             XK_k,          moveresize,        {.v = (int []){   0, -25,   0,   0 }}}, /* move up    */
    {  MOD4|MOD1,             XK_l,          moveresize,        {.v = (int []){  25,   0,   0,   0 }}}, /* move right */
    {  MOD4|MOD1,             XK_h,          moveresize,        {.v = (int []){ -25,   0,   0,   0 }}}, /* move left  */
    {  MOD4|MOD1|SHIFT,       XK_j,          moveresize,        {.v = (int []){   0,   0,   0,  25 }}}, /* height grow   */
    {  MOD4|MOD1|SHIFT,       XK_k,          moveresize,        {.v = (int []){   0,   0,   0, -25 }}}, /* height shrink */
    {  MOD4|MOD1|SHIFT,       XK_l,          moveresize,        {.v = (int []){   0,   0,  25,   0 }}}, /* width grow    */
    {  MOD4|MOD1|SHIFT,       XK_h,          moveresize,        {.v = (int []){   0,   0, -25,   0 }}}, /* width shrink  */
       DESKTOPCHANGE(    XK_F1,                             0)
       DESKTOPCHANGE(    XK_F2,                             1)
       DESKTOPCHANGE(    XK_F3,                             2)
       DESKTOPCHANGE(    XK_F4,                             3)
       MONITORCHANGE(    XK_comma,                             0)
       MONITORCHANGE(    XK_period,                             1)
};

/**
 * mouse shortcuts
 */
static Button buttons[] = {
    {  MOD1,    Button1,     mousemotion,   {.i = MOVE}},
    {  MOD1,    Button3,     mousemotion,   {.i = RESIZE}},
};
#endif

/* vim: set expandtab ts=4 sts=4 sw=4 : */