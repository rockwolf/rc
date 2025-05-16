;;; evil-tabs-autoloads.el --- automatically extracted autoloads  -*- lexical-binding: t -*-
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "evil-tabs" "evil-tabs.el" (0 0 0 0))
;;; Generated autoloads from evil-tabs.el

(defvar evil-tabs-mode nil "\
Non-nil if Evil-Tabs mode is enabled.
See the `evil-tabs-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `evil-tabs-mode'.")

(custom-autoload 'evil-tabs-mode "evil-tabs" nil)

(autoload 'evil-tabs-mode "evil-tabs" "\
Integrating Vim-style tabs for Evil mode users.

This is a minor mode.  If called interactively, toggle the
`Evil-Tabs mode' mode.  If the prefix argument is positive,
enable the mode, and if it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable
the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate `(default-value \\='evil-tabs-mode)'.

The mode's hook is called both when the mode is enabled and when
it is disabled.

\(fn &optional ARG)" t nil)

(autoload 'turn-on-evil-tabs-mode "evil-tabs" "\
Enable `evil-tabs-mode' in the current buffer." nil nil)

(autoload 'turn-off-evil-tabs-mode "evil-tabs" "\
Disable `evil-tabs-mode' in the current buffer." nil nil)

(put 'global-evil-tabs-mode 'globalized-minor-mode t)

(defvar global-evil-tabs-mode nil "\
Non-nil if Global Evil-Tabs mode is enabled.
See the `global-evil-tabs-mode' command
for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `global-evil-tabs-mode'.")

(custom-autoload 'global-evil-tabs-mode "evil-tabs" nil)

(autoload 'global-evil-tabs-mode "evil-tabs" "\
Toggle Evil-Tabs mode in all buffers.
With prefix ARG, enable Global Evil-Tabs mode if ARG is positive;
otherwise, disable it.

If called from Lisp, toggle the mode if ARG is `toggle'.
Enable the mode if ARG is nil, omitted, or is a positive number.
Disable the mode if ARG is a negative number.

Evil-Tabs mode is enabled in all buffers where
`turn-on-evil-tabs-mode' would do it.

See `evil-tabs-mode' for more information on Evil-Tabs mode.

\(fn &optional ARG)" t nil)

(register-definition-prefixes "evil-tabs" '("evil-tabs-mode-map"))

;;;***

;;;### (autoloads nil nil ("evil-tabs-pkg.el") (0 0 0 0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; evil-tabs-autoloads.el ends here
