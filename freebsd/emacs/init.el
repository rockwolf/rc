;; packages
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "https://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(when (< emacs-major-version 24)
  ; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; theme
(load-theme 'solarized-dark t)
(color-theme-approximate-on)

;; load-path
; Add dir for custom scripts, like window-number.el
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Look 'n Feel
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; evil - leader key
(require 'evil-leader)
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

;; evil
(evil-mode 1)

;; evil - cursor
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))

;; evil - tab behaviour #gt
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

;; evil - dired
(evil-set-initial-state 'dired-mode 'normal)
(evil-set-initial-state 'Buffer-menu-mode 'normal)
(setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))
(setq evil-emacs-state-modes (delq 'dired-mode evil-emacs-state-modes))

;; accents - to make them work in gui mode
(require 'iso-transl)

;; After macro
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

;; evil - search highlighting
;(require 'evil-search-highlight-persist)
;(global-evil-search-highlight-persist t)
;(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all) ; clear search highlights

;; Helm/Ctrl-P
;; helm settings (TAB in helm window for actions over selected items,
;; C-SPC to select items)
(require 'helm-config)
(require 'helm-misc)
(require 'helm-projectile)
(require 'helm-locate)
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)
(global-set-key (kbd "M-x") 'helm-M-x);; 

(after 'projectile
  (require 'helm-projectile))
(global-set-key (kbd "M-x") 'helm-M-x)

(defun helm-my-buffers ()
  (interactive)
  (let ((helm-ff-transformer-show-only-basename nil))
  (helm-other-buffer '(helm-c-source-buffers-list
                       helm-c-source-elscreen
                       helm-c-source-projectile-files-list
                       helm-c-source-ctags
                       helm-c-source-recentf
                       helm-c-source-locate)
                     "*helm-my-buffers*")))

;; Save bookmarks
;; save bookmarks
(setq bookmark-default-file "~/.emacs.d/bookmarks"
      bookmark-save-flag 1) ;; save after every change

;; Project explorer
;(require 'project-explorer)
;(after 'project-explorer
;  (setq pe/cache-directory "~/.emacs.d/cache/project_explorer")
;  (setq pe/omit-regex (concat pe/omit-regex "\\|single_emails")))

;; Smooth scrolling
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)

;; Don't make automatic backups
(setq make-backup-files nil)

;; Remember current position
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)

;; Powerline
(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;; Diminish, removes minor modes from the powerline
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

;; Flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)

(after 'flycheck
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
  (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
  (setq flycheck-standard-error-navigation nil))

(global-flycheck-mode t)

; flycheck errors on a tooltip (doesnt work on console)
(when (display-graphic-p (selected-frame))
  (eval-after-load 'flycheck
    '(custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages))))

;; ESC escapes, instead of needing to press it 3 times.
;; esc quits
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

;; Scroll window with ctrl-j/ctrl-k
(define-key evil-normal-state-map (kbd "C-k") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "C-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))

;; Move between windows.
;(global-set-key (kbd "K") 'windmove-up)
;(global-set-key (kbd "J") 'windmove-down)
;(global-set-key (kbd "H") 'windmove-left)
;(global-set-key (kbd "L") 'windmove-right)
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

;; No tabs for indentation, for crying out loud, emacs!
(setq-default tab-width 4 indent-tabs-mode nil)

;; Matching parens

;; Automatically added
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (## winum window-number evil-nerd-commenter helm evil-tabs powerline helm-projectile flycheck evil-search-highlight-persist evil-leader color-theme-solarized))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
