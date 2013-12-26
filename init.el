;; init.el --- Where all the magic begins
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

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

;; Load up Org Mode and (now included) Org Babel for elisp embedded in Org Mode files
(dolist (package '(org org-plus-contrib))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'org-install)
(require 'ob-tangle)

;; load up all literate org-mode files in this directory
(setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))
(mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

;;; init.el ends here
