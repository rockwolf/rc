xrdb -merge -nocpp ~/.Xresources

## daemons and apps
DISPLAY=:0.0 urxvtd &
DISPLAY=:0.0 randomwall &
#DISPLAY=:0.0 wallpaper &
setxkbmap colemak &
dropboxd &
#stalonetray &
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 5 --transparent true --tint 0x002b36 --height 12 &

## UIM
#DISPLAY=:0.0 scim -d &
#ibus-daemon --xim &
export GTK_IM_MODULE='uim'
export QT_IM_MODULE='uim'
uim-xim &
export XMODIFIERS=@im='uim'
#uim-toolbar-qt4 &

## time and reminders
DISPLAY=:0.0 al-remind &
#DISPLAY=:0.0 taajm &
timetokyo &

## WM
DISPLAY=:0.0 startwm
