;; packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
			("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")
			("melpa" . "http://melpa.milkbox.net/packages/")))
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

;; evil - cursor
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))


;; evil - tab behaviour #gt
(define-key evil-normal-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-normal-state-map (kbd "C- ") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-normal-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
(define-key evil-normal-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
(define-key evil-normal-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
(define-key evil-normal-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
(define-key evil-normal-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
(define-key evil-normal-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
(define-key evil-normal-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
(define-key evil-normal-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
(define-key evil-normal-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))
(define-key evil-insert-state-map (kbd "C-0") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-insert-state-map (kbd "C- ") (lambda() (interactive) (elscreen-goto 0)))
(define-key evil-insert-state-map (kbd "C-1") (lambda() (interactive) (elscreen-goto 1)))
(define-key evil-insert-state-map (kbd "C-2") (lambda() (interactive) (elscreen-goto 2)))
(define-key evil-insert-state-map (kbd "C-3") (lambda() (interactive) (elscreen-goto 3)))
(define-key evil-insert-state-map (kbd "C-4") (lambda() (interactive) (elscreen-goto 4)))
(define-key evil-insert-state-map (kbd "C-5") (lambda() (interactive) (elscreen-goto 5)))
(define-key evil-insert-state-map (kbd "C-6") (lambda() (interactive) (elscreen-goto 6)))
(define-key evil-insert-state-map (kbd "C-7") (lambda() (interactive) (elscreen-goto 7)))
(define-key evil-insert-state-map (kbd "C-8") (lambda() (interactive) (elscreen-goto 8)))
(define-key evil-insert-state-map (kbd "C-9") (lambda() (interactive) (elscreen-goto 9)))

;; evil - leader key
(setq evil-leader/in-all-states 1)
(global-evil-leader-mode)
(evil-leader/set-leader ",")

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
(require 'evil-search-highlight-persist)
(global-evil-search-highlight-persist t)
(evil-leader/set-key "SPC" 'evil-search-highlight-persist-remove-all) ; clear search highlights

;; Automatically added
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-tabs powerline helm-projectile flycheck evil-search-highlight-persist evil-leader color-theme-solarized))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
