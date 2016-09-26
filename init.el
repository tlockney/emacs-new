;; clean & simple UI

(tool-bar-mode 0) 
(menu-bar-mode 0)
(toggle-frame-fullscreen) 
(scroll-bar-mode 0)
(fset `yes-or-no-p `y-or-n-p)
(transient-mark-mode t)
(column-number-mode t)
(setq major-mode 'text-mode
      inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil
      initial-major-mode 'org-mode
      confirm-nonexistent-file-or-buffer nil
      kill-buffer-query-functions (remq 'process-kill-buffer-query-function
                                        kill-buffer-query-functions))
(tooltip-mode -1)

;; make sure everything is where I left it

(desktop-save-mode 1)
(setq desktop-path '("~")
      desktop-base-file-name ".emacs-desktop")
(require 'saveplace)
(setq-default save-place t)
(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'comint-mode)
(add-to-list 'desktop-modes-not-to-save 'doc-view-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)

;; make sure the mouse works the way I expect it to

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (mouse-wheel-mode t))

;; set up the basic package stuff

(require 'package)
(setq
 use-package-always-ensure t
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))

;; load use-package for loading other packages more easily
(require 'use-package)

;; load a reasonable theme

(use-package solarized-theme
  :ensure t
  :config
  (progn (load-theme 'solarized-dark t)))

;; set up a few basic bits and pieces

(setq user-full-name "Thomas Lockney"
      user-mail-address "thomas@lockney.net"
      custom-file "~/.emacs.d/custom.el")
(setq mac-command-modifier 'super)
(global-font-lock-mode t)

;; start the server

(require 'server)
(unless (server-running-p) (server-start))

;; load everything else via org-mode

(org-babel-do-load-languages
 'org-babel-load-languages
 '((awk . t)
   (C . t)
   (emacs-lisp . t)
   (java . t)
   (ocaml . t)
   (python . t)
   (R . t)
   (ruby . t)
   (scala . t)
   (sh . t)
   (sql . t)
   ))
(setq org-src-fontify-natively t)
(setq org-confirm-babel-evaluate nil)
(add-to-list 'org-babel-default-header-args:sh
	     '(:shebang . "#!/usr/bin/env bash"))
(org-babel-load-file (concat user-emacs-directory "readme.org"))


