;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")
 '(ansi-color-names-vector ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#ad7fa8" "#8cc4ff" "#eeeeec"])
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/data/backup/" t))))
 '(auto-save-list-file-prefix "~/data/auto-save-list/.saves-")
 '(backup-directory-alist (quote (("\\.*$" . "~/.emacs.d/data/backup"))))
 '(blink-cursor-mode t)
 '(bookmark-default-file "~/.emacs.d/data/bookmarks")
 '(column-number-mode t)
 '(compilation-ask-about-save nil)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(custom-safe-themes (quote ("fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a" default)))
 '(debug-on-error t)
 '(display-time-mode t)
 '(fci-rule-color "#383838")
 '(graphviz-dot-preview-extension "pdf")
 '(inhibit-startup-screen nil)
 '(mediawiki-site-alist (quote (("YC's MediaWiki" "http://wiki.chubachi.net/" "yc" "" "メインページ"))))
 '(mouse-drag-copy-region t)
 '(org-agenda-custom-commands (quote (("x" "Unscheduled TODOs" tags-todo "-SCHEDULED>=\"<today>\"" nil) ("n" "Agenda and all TODO's" ((agenda "" nil) (alltodo "" nil)) nil))))
 '(org-agenda-files (quote ("~/.emacs.d/init.org" "/home/yc/Dropbox/Org/journal.org" "/home/yc/Dropbox/Org/notes.org" "/home/yc/Dropbox/Org/todo.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (java . t) (ruby . t) (sh . t))))
 '(org-capture-templates (quote (("t" "Todo" entry (file+headline "todo.org" "Tasks") "* TODO %?
  %i
  %a") ("j" "Journal" entry (file+datetree "journal.org") "* %?
作成日 %U
  %i
  %a"))))
 '(org-confirm-babel-evaluate nil)
 '(org-default-notes-file "notes.org")
 '(org-directory "~/Dropbox/Org")
 '(org-export-in-background nil)
 '(org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
 '(org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")
 '(org-src-fontify-natively t)
 '(org-startup-with-inline-images t)
 '(org-tag-alist (quote (("@MAIL" . 109) ("@WEB" . 119) ("@PHONE" . 112) ("@OFFICE" . 111) ("@HOME" . 104))))
 '(org-todo-keywords (quote ((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)" "CANCEL(c)"))))
 '(org2blog/wp-use-sourcecode-shortcode t)
 '(outline-minor-mode-prefix "")
 '(package-archives (quote (("org" . "http://orgmode.org/elpa/") ("gnu" . "http://elpa.gnu.org/packages/") ("marmalade" . "http://marmalade-repo.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(prelude-clean-whitespace-on-save t)
 '(prelude-flyspell nil)
 '(prelude-guru nil)
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-z")
 '(shell-pop-window-height 30)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(smart-compile-alist (quote ((emacs-lisp-mode emacs-lisp-byte-compile) (html-mode browse-url-of-buffer) (nxhtml-mode browse-url-of-buffer) (html-helper-mode browse-url-of-buffer) (octave-mode run-octave) ("\\.c\\'" . "gcc -O2 %f -lm -o %n") ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n") ("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n") ("\\.java\\'" . "javac %f") ("\\.php\\'" . "php -l %f") ("\\.f90\\'" . "gfortran %f -o %n") ("\\.[Ff]\\'" . "gfortran %f -o %n") ("\\.cron\\(tab\\)?\\'" . "crontab %f") ("\\.tex\\'" tex-file) ("\\.texi\\'" . "makeinfo %f") ("\\.mp\\'" . "mptopdf %f") ("\\.pl\\'" . "perl -cw %f") ("\\.rb\\'" . "bundle exec ruby %f"))))
 '(tool-bar-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(vc-follow-symlinks t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal))))
 '(org-column-title ((t (:background "grey30" :underline t :weight bold :height 135)))))
