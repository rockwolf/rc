(load "~/.config/colors.lisp")

(set-font `(,(make-instance 'xft:font :family "Inconsolata" :size 11 :antialias t)))

(set-border-color gruvbox-bg)
(set-focus-color gruvbox-green-bright)
(set-unfocus-color gruvbox-green)
(set-float-focus-color gruvbox-green-bright)
(set-float-unfocus-color gruvbox-green)
(set-fg-color gruvbox-fg)
(set-bg-color gruvbox-bg)
(setf *normal-border-width* 0
      *float-window-border* 0
      *float-window-title-height* 15
      *window-border-style* :none
      *window-format* "%n:%t")

(setf *input-window-gravity* :top
      *message-window-padding* 10
      *message-window-y-padding* 10
      *message-window-gravity* :top)

(load-module "swm-gaps")
(setf swm-gaps:*head-gaps-size* 0
      swm-gaps:*inner-gaps-size* 3
      swm-gaps:*outer-gaps-size* 40)
(when *initializing*
  (swm-gaps:toggle-gaps))
