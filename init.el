
;; init.el --- packageの初期化とorgファイルからのel生成
;;
;; This file loads Org-mode and then loads the rest of our Emacs initialization from Emacs lisp
;; embedded in literate Org-mode files.

(require 'package)
(setq package-archives '(("org" .
                          "http://orgmode.org/elpa/")
                         ("gnu" .
                          "http://elpa.gnu.org/packages/")
                         ("marmalade" .
                          "http://marmalade-repo.org/packages/")
                         ("melpa" .
                          "http://melpa.milkbox.net/packages/")
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
(setq dotfiles-dir
      (concat
       (file-name-directory ; ファイル名のデレクトリ部分
        (or
         (buffer-file-name)
         load-file-name))
       "org/"
       ))

(message dotfiles-dir)

(mapc #'org-babel-load-file
      (directory-files dotfiles-dir t "\\.org$"))

;;; init.el ends here
