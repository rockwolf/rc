/* See LICENSE file for copyright and license details. */
//dwm 6.0

/* appearance */
//static const char font[]            = "-*-sazanami gothic-*-*-*-*-12-*-*-*-*-*-*-*";
//static const char font[]            = "-*-Inconsolata-medium-*-*-*-18-*-*-*-*-*-*-*";
static const char font[]            = "Inconsolata 16";
//solarized - dark
static const char normbordercolor[] = "#002b36";
static const char normbgcolor[]     = "#002b36";
static const char normfgcolor[]     = "#85cc00";
static const char selbordercolor[]  = "#85cc00";
static const char selbgcolor[]      = "#002b36";
static const char selfgcolor[]      = "#85ff00";
//solarized - light
/*static const char normbordercolor[] = "#ffffd7";
static const char normbgcolor[]     = "#ffffd7";
static const char normfgcolor[]     = "#626262";
static const char selbordercolor[]  = "#626262";
static const char selbgcolor[]      = "#ffffd7";
static const char selfgcolor[]      = "#626262";
*/
//reloaded
/*
static const char normbordercolor[] = "#000a00";
static const char normbgcolor[]     = "#000a00";
static const char normfgcolor[]     = "#00ff00";
static const char selbordercolor[]  = "#006400";
static const char selbgcolor[]      = "#000a00";
static const char selfgcolor[]      = "#00ff00";
*/
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 16;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */

/* tagging */
static const char *tags[] = {"~", "★", "☎", "☆", "卍", "♫"};

static const Rule rules[] = {
    /* class      instance    title       tags mask     isfloating   monitor */
    { "Gimp",     NULL,       NULL,       1 << 6,            True,        -1 },
    { "Firefox",  NULL,       NULL,       1 << 1,           False,       -1 },
    { "MPlayer",  NULL,       NULL,       ~0,               True,       -1 },
    { "feh",      NULL,       NULL,       ~0,               True,       -1 },
    { "Xpdf",      NULL,       NULL,       ~0,               True,       -1 },
    { "XClock",      NULL,       NULL,       ~0,               True,       -2 },
    { "game",      NULL,       NULL,       ~0,               True,       -2 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1; /* number of clients in master area */
static const Bool resizehints = True; /* True means respect size hints in tiled resizals */

#include "bstack.c"
#include "bstackhoriz.c"
static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[ ]",      monocle },
    { "[]=",      tile },    /* first entry is default */
    { "TTT",      bstack },
    { "><>",      NULL },    /* no layout function means floating behavior */
    { "===",      bstackhoriz }
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
//static const char *termcmd[]  = { "urxvtc -e tmux -2 new-session", NULL };
static const char *termcmd[]  = { "urxvt", NULL };
static const char *warpcmd[]  = { "/usr/local/sh/warp", NULL };

static Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
    { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Return, zoom,           {0} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
    { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[1]} },
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[3]} },
    { MODKEY,                       XK_e,      setlayout,      {.v = &layouts[4]} },
    { MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    //{ MODKEY,                       XK_comma,  spawn,       {.v = warpcmd } },
    { MODKEY|ControlMask,                       XK_comma,  spawn,       {.v = warpcmd } },
    { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    //{ MODKEY,                       XK_period, spawn,       {.v = warpcmd } },
    { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
    { 0,                            0x1008ff81,      spawn,          {.v = "/usr/local/sh/KeyMedia"} },
    { 0,                            0x1008ff14,      spawn,          {.v = "/usr/local/sh/KeyPlay"} },
    { 0,                            0x1008ff12,      spawn,          {.v = "/usr/local/sh/KeyMute"} },
    { 0,                            0x1008ff30,      spawn,          {.v = "/usr/local/sh/KeyFavorites"} },
    { 0,                            0x1008ff19,      spawn,          {.v = "/usr/local/sh/KeyMail"} },
    { 0,                            0x1008ff18,      spawn,          {.v = "/usr/local/sh/KeyWWW"} },
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    //TAGKEYS(                        XK_7,                      6)
    //TAGKEYS(                        XK_8,                      7)
    //TAGKEYS(                        XK_9,                      8)
    //TAGKEYS(                        XK_0,                      9)
    { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

