;; Keep track of loading time
(defconst emacs-start-time (current-time))

;; Packages
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
     (message "Loaded packages in %.3fs" elapsed))

(defun require-package (package)
  (setq-default highlight-tabs t)
  "Install given PACKAGE."
  (unless (package-installed-p package)
    (unless (assoc package package-archive-contents)
      (package-refresh-contents))
    (package-install package)))

;; Keep customize settings in a seperate file
(setq custom-file "~/.emacs.d/custom.el")
(when (file-exists-p custom-file)
      (load custom-file))

(require 'org)
(org-babel-load-file
  (expand-file-name "config.org" user-emacs-directory))

;; Message how long it took to load everything (minus packages)
(let ((elapsed (float-time (time-subtract (current-time) emacs-start-time))))
     (message "Loading settings...done (%.3fs)" elapsed))
