;; load paths
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp" "config")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)

;; package.elでelispを入れるdirectoryの設定
(setq package-user-dir "~/.emacs.d/elpa/")

;; MELPAを追加
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

;; Packages to install from MELPA
(defvar my/packages
  '(magit)
  "A list of packages to install from MELPA at launch.")

;; Install Melpa packages
(dolist (package my/packages)
  (when (or (not (package-installed-p package)))
    (package-install package)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package-initialize)
;; load my configrations.
(load "emacs-kicker")			; el-get and several configrations.
(load "my-ibus")			; ibus configrations.
; (load "my-mozc")                        ; mozc
(load "my-ruby")			; ruby-mode
(load "my-yatex")			; yatex
(load "my-auto-complete")		; auto-complete
(load "my-redo+")
(load "my-haml")
(load "my-scss")
(load "my-coffee")
(load "my-json")			; use js2-mode for json.

;; Emacs
(setq inhibit-startup-screen t)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; key bindings
(keyboard-translate ?\C-h ?\C-?)
(global-set-key (kbd "C-x ?") 'help-command)

;; backup
(setq make-backup-files nil)		; disable backup files.

;; paren
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face nil)
(set-face-underline-p 'show-paren-match-face "yellow")

;; ;; Magit
;; (require 'magit)
;; (global-set-key (kbd "M-v") 'magit-status)

;; ;; flymake
;; (require 'flymake)
;; (global-set-key [f3] 'flymake-display-err-menu-for-current-line)
;; (global-set-key [f4] 'flymake-goto-next-error)

;; ;; flymake-haml
;; (require 'flymake-haml)
;; (add-hook 'haml-mode-hook 'flymake-haml-load)
