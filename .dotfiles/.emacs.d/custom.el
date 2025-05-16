(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" default))
 '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
 '(inhibit-startup-screen t)
 '(ledger-init-file-name "~/dev/rc/ledgerrc")
 '(package-selected-packages
   '(org-roam gruvbox-theme evil-collection magit ssh-agency browse-url-dwim powerline-evil rainbow-delimiters diminish evil rust-mode writeroom-mode evil-vimish-fold slime dokuwiki-mode dokuwiki org-link-minor-mode flycheck-ledger ledger-mode paredit ranger neotree ## winum window-number evil-nerd-commenter helm evil-tabs powerline helm-projectile flycheck evil-search-highlight-persist evil-leader color-theme-solarized))
 '(warning-suppress-types '((initialization) (initialization) (initialization))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-font-other-face ((t (:foreground "#eee8d5" :weight normal))))
 '(ledger-font-payee-cleared-face ((t (:inherit ledger-font-posting-account-face))))
 '(ledger-font-payee-pending-face ((t (:foreground "#2aa198" :weight normal))))
 '(ledger-font-payee-uncleared-face ((t (:foreground "#899900" :weight normal))))
 '(ledger-font-pending-face ((t (:foreground "#2aa198" :weight normal))))
 '(ledger-font-periodic-xact-face ((t (:foreground "#2aa198" :weight normal))))
 '(ledger-font-posting-account-cleared-face ((t (:inherit ledger-font-posting-account-face))))
 '(ledger-font-posting-account-face ((t (:foreground "#859900"))))
 '(ledger-font-posting-amount-cleared-face ((t (:inherit ledger-font-posting-amount-face))))
 '(ledger-font-posting-amount-face ((t (:foreground "#eee8d5"))))
 '(ledger-font-posting-amount-pending-face ((t (:inherit ledger-font-posting-amount-face))))
 '(ledger-font-posting-date-face ((t (:foreground "#93a1a1"))))
 '(ledger-font-xact-pending-face ((t (:foreground "#93a1a1" :weight normal)))))
