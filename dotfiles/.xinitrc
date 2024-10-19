
################################################################################
# Author: Andy Nagels
# Date: 2015-03-04
#
# .xinitrc:
# Settings, to be loaded when the X-server starts.
################################################################################

xinitrc_settings_language.fish &
xinitrc_settings_general.fish &
xinitrc_custom_scripts.fish &
redshift &
#exec stumpwm
#exec ssh-agent stumpwm
#exec ssh-agent /usr/local/dt/bin/Xsession
exec ssh-agent i3
#exec i3
