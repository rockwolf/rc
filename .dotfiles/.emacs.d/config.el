;; "after" macro definition
(if (fboundp 'with-eval-after-load)
    (defmacro after (feature &rest body)
      "After FEATURE is loaded, evaluate BODY."
      (declare (indent defun))
      `(with-eval-after-load ,feature ,@body))
  (defmacro after (feature &rest body)
    "After FEATURE is loaded, evaluate BODY."
    (declare (indent defun))
    `(eval-after-load ,feature
       '(progn ,@body))))

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq calendar-week-start-day 1)

(load-theme 'gruvbox-dark-hard t)
(set-frame-parameter nil 'background-mode 'dark)
(set-terminal-parameter nil 'background-mode 'dark)
(enable-theme 'gruvbox-dark-hard)
;(add-to-list 'default-frame-alist '(background-color . "black"))
;(set-frame-parameter (selected-frame) 'alpha '(0 . 0))
;(add-to-list 'default-frame-alist '(alpha 0 0))

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;(set-default-font "inconsolata-16")
(add-to-list 'default-frame-alist '(font . "inconsolata-12"))
(set-face-attribute 'default t :font "inconsolata-12")
(set-face-attribute 'default nil :font "inconsolata-12")
(set-frame-font "inconsolata-16" nil t)

(global-linum-mode t)
(setq linum-format "%d ")

(require 'org-bullets)
(setq org-bullets-face-name (quote org-bullet-face))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq ls-lisp-use-insert-directory-program nil)
(setq dired-listing-switches "-alh")

(global-visual-line-mode t)
(set-display-table-slot standard-display-table 'wrap ?\ )

(require 'iso-transl)

(setq bookmark-default-file "~/.emacs.d/bookmarks"
      bookmark-save-flag 1) ;; save after every change

(setq scroll-margin 5
      scroll-conservatively 9999
      scroll-step 1)

(setq make-backup-files nil)

(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place-mode t)
(require 'saveplace)

(require 'diminish)
(diminish 'visual-line-mode)
(after 'autopair (diminish 'autopair-mode))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'projectile (diminish 'projectile-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'company (diminish 'company-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'magit (diminish 'magit-auto-revert-mode))
(after 'hs-minor-mode (diminish 'hs-minor-mode))
(after 'color-identifiers-mode (diminish 'color-identifiers-mode))

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(after 'flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
  (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
  (setq flycheck-standard-error-navigation nil))

(global-flycheck-mode t)

; flycheck errors on a tooltip (doesnt work on console)
;(when (display-graphic-p (selected-frame))
;  (eval-after-load 'flycheck
;    '(custom-set-variables
;      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

(setq evil-want-keybinding nil) 
(setq evil-want-integration t)
(setq evil-want-C-u-delete t) ; To fix error with magit
(require 'evil)
(evil-mode 1)
;; Use visual line motions even outside of visual-line-mode buffers
(evil-global-set-key 'motion "j" 'evil-next-visual-line)
(evil-global-set-key 'motion "k" 'evil-previous-visual-line)
(evil-collection-init)

; Note:
; Regain TAB functionality,
; must be called before activating evil-mode.
(setq evil-want-C-i-jump nil) 
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

(global-evil-tabs-mode t)
;(define-key evil-normal-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
;(define-key evil-normal-state-map (kbd "C- ") (lambda() (interactive) (elscreen-goto 0)))
;(define-key evil-normal-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
;(define-key evil-normal-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
;(define-key evil-normal-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
;(define-key evil-normal-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
;(define-key evil-normal-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
;(define-key evil-normal-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
;(define-key evil-normal-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
;(define-key evil-normal-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
;(define-key evil-normal-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))
;(define-key evil-insert-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
;(define-key evil-insert-state-map (kbd "C- ") (lambda() (interactive) (elscreen-goto 0)))
;(define-key evil-insert-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
;(define-key evil-insert-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
;(define-key evil-insert-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
;(define-key evil-insert-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
;(define-key evil-insert-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
;(define-key evil-insert-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
;(define-key evil-insert-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
;(define-key evil-insert-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
;(define-key evil-insert-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))

;(require 'evil-search-highlight-persist)
;(global-evil-search-highlight-persist t)
;(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all) ; clear search highlights

(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)

(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                      (interactive)
                      (evil-scroll-up nil)))
  (define-key evil-normal-state-map (kbd "C-j") (lambda ()
                          (interactive)
                          (evil-scroll-down nil)))
(define-prefix-command 'my-window-map)

(evil-vimish-fold-mode 1)

(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

(add-hook 'dired-mode-hook 'evil-normal-state) ; Fix for evil-normal-state not activating
(evil-collection-define-key 'normal 'dired-mode-map
  "h" 'dired-up-directory
  "l" 'dired-find-file)
(evil-leader/set-key "j" 'dired-jump)

(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key)
(which-key-mode)
(which-key-setup-side-window-bottom)

(require 'neotree)
(global-set-key (kbd "M-t") 'neotree-toggle)
(setq neo-window-fixed-size nil)
(setq default-directory "~/doc/personal/wiki")

(require 'magit)

(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)
; leader+num based movement between windows and frames
(require 'winum)
(setq winum-keymap
    (let ((map (make-sparse-keymap)))
      (evil-leader/set-key "0" 'winum-select-window-0-or-10)
      (evil-leader/set-key "1" 'winum-select-window-1)
      (evil-leader/set-key "2" 'winum-select-window-2)
      (evil-leader/set-key "3" 'winum-select-window-3)
      (evil-leader/set-key "4" 'winum-select-window-4)
      (evil-leader/set-key "5" 'winum-select-window-5)
      (evil-leader/set-key "6" 'winum-select-window-6)
      (evil-leader/set-key "7" 'winum-select-window-7)
      (evil-leader/set-key "8" 'winum-select-window-8)
      (evil-leader/set-key "9" 'winum-select-window-8)
      map))
(winum-mode)

(setq-default tab-width 4 indent-tabs-mode nil)

(add-hook 'term-setup-hook '(lambda () (define-key function-key-map "\e[Z" [backtab])))

(show-paren-mode 1)
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
;(require 'helm-misc)
;(require 'helm-projectile)
;(require 'helm-locate)
;(setq helm-quick-update t)
;(setq helm-bookmark-show-location t)
;(setq helm-buffers-fuzzy-matching t)
;(global-set-key (kbd "M-x") 'helm-M-x) 

;(after 'projectile
;  (require 'helm-projectile))
;(global-set-key (kbd "M-x") 'helm-M-x)

;(defun helm-my-buffers ()
;  (interactive)
;  (let ((helm-ff-transformer-show-only-basename nil))
;  (helm-other-buffer '(helm-c-source-buffers-list
;                       helm-c-source-elscreen
;                       helm-c-source-projectile-files-list
;                       helm-c-source-ctags
;                       helm-c-source-recentf
;                       helm-c-source-locate)
;                     "*helm-my-buffers*")))

(autoload 'ledger-mode "ledger-mode" "A major mode for ledger" t)
(add-to-list 'auto-mode-alist '("\\.dat$" . ledger-mode))
; Note: ledger-init-file-name is set in custom-set-variables,
; because it can't handle .ledgerrc being a symlink.
(global-set-key (kbd "C-c f") 'ledger-mode-clean-buffer)
(global-set-key (kbd "C-c r") 'ledger-post-align-postings)
; Alignment is 52 by default, but I have long account names.
(setq ledger-post-amount-alignment-column 80)

; Display images
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images "inlineimages")
; Note: The below changes the size of the inline images to 1/3 of the width of the document
;(setq org-image-actual-width (/ (display-pixel-width) 3))
(setq org-image-actual-width nil)
(setq org-link-frame-setup '((vm . vm-visit-folder-other-frame)
 (vm-imap . vm-visit-imap-folder-other-frame)
 (gnus . org-gnus-no-new-news)
 (file . find-file)
 (wl . wl-other-frame)))

(defun zin/org-open-other-window ()
  "Jump to bookmark in another frame. See `bookmark-jump' for more."
  (interactive)
  (let ((org-link-frame-setup (acons 'file 'find-file-other-window org-link-frame-setup)))
    (org-open-at-point)))
(global-set-key (kbd "C-c 5 C-o") 'zin/org-open-other-window)

;(setq org-agenda-files
;    '("~/doc/wiki/todo.org"))
;(setq org-todo-keywords
;    '((sequence "TODO(t)" "IN_PROGRESS(p)" "|" "DONE(d!)")))
;
; (setq org-refile-targets
;    '(("~/doc/wiki/doc/personal/archived.org" :maxlevel . 1)
;      ("~/doc/wiki/doc/ppw/archived.org" :maxlevel . 1)
;      ("~/doc/wiki/doc/nintai/archived.org" :maxlevel . 1)))
;
; (setq org-agenda-custom-commands
;   '(("p" "In progress"
;     ((todo "IN_PROGRESS"
;        ((org-agenda-overriding-header "In progress")))))))
;; Save Org buffers after refiling!
;(advice-add 'org-refile :after 'org-save-all-org-buffers)

;(setq dokuwiki-xml-rpc-url "http://localhost:8800/lib/exe/xmlrpc.php")
;(setq dokuwiki-login-user-name "anagels")

(cond
 ((string-equal system-type "windows-nt") ; Microsoft Windows
  (progn
    (prefer-coding-system 'utf-8)
    (setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
    (setq explicit-bash.exe-args '("--login" "-i"))
    (defun git-bash() (interactive)
      (call-interactively 'shell))
)))

(setenv "SSH_ASKPASS" "git-gui--askpass")

(require 'org-roam)
(global-set-key (kbd "C-c n l") 'org-roam-buffer-toggle)
(global-set-key (kbd "C-c n f") 'org-roam-node-find)
(global-set-key (kbd "C-c n g") 'org-roam-graph)
(global-set-key (kbd "C-c n i") 'org-roam-node-insert)
(global-set-key (kbd "C-c n c") 'org-roam-capture)
(global-set-key (kbd "C-c n j") 'org-roam-capture-today) ;; Dailies
(setq org-roam-directory (file-truename "~/doc/personal/wiki/doc/pkm"))
(org-roam-setup)

;; if you want to change prefix for lsp-mode keybindings.
(setq lsp-keymap-prefix "C-c l")

(require 'lsp-mode)
(add-hook 'csharp-mode-hook #'lsp)
(require 'lsp-ui)

;; The path to lsp-mode needs to be added to load-path as well as the
;; path to the `clients' subdirectory.
(add-to-list 'load-path (expand-file-name "lib/lsp-mode" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "lib/lsp-mode/clients" user-emacs-directory))

(require 'rust-mode)
(add-hook 'rust-mode-hook
  (lambda () (setq indent-tabs-mode nil)))

; Note: slime-helper install
; via (ql:quickload "quicklisp-slime-helper")
;(setq inferior-lisp-program "sbcl")
;(slime-setup '(slime-company))
;(load (expand-file-name "~/quicklisp/slime-helper.el"))

(global-set-key (kbd "C--") 'pop-tag-mark) 
(global-set-key (kbd "C-]") 'xref-find-definitions)
(global-set-key (kbd "C-S-o") 'helm-find-files)
