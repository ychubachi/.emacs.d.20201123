
(require 'package)
(setq package-user-dir "~/.emacs.d/packages/")
(setq package-archives '(("gnu" .
                          "http://elpa.gnu.org/packages/")
                         ("marmalade" .
                          "http://marmalade-repo.org/packages/")
                         ("melpa" .
                          "http://melpa.milkbox.net/packages/")
                         ("org" .
                          "http://orgmode.org/elpa/")
                         ))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

(when (not (package-installed-p 'init-loader))
  (package-install 'init-loader))
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
; (setq init-loader-show-log-after-init nil)

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom.el"))
    (load (expand-file-name custom-file) t nil nil))
