;;; ロードパスの設定

;; normal-top-level-add-subdirs-to-load-path は
;; default-directory の全てのサブディレクトリを load-path に追加する
;; 関数です．

;; gitのsubmoduleとして管理するライブラリを追加します．
(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

;; ソースコードで管理するライブラリを追加します．
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;;; init-loaderの起動
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/data/backup/" t))))
 '(auto-save-list-file-prefix "~/.emacs.d/data/auto-save-list/saves-")
 '(backup-directory-alist (quote (("\\.*$" . "~/.emacs.d/data/backup"))))
 '(bookmark-default-file "~/.emacs.d/data/bookmarks")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist
   (quote
    (("YC's MediaWiki" "http://wiki.chubachi.net/" "yc" "" "メインページ"))))
 '(message-signature "Yoshihide Chubachi @AIIT")
 '(mouse-drag-copy-region t)
 '(mouse-yank-at-point t)
 '(mu4e-attachment-dir "~/Downloads")
 '(mu4e-user-mail-address-list
   (quote
    ("yc@aiit.ac.jp" "yoshi@chubachi.net" "yoshihide.chubachi@gmail.com")))
 '(op/repository-directory "/home/yc/git/ychubachi.github.io")
 '(op/site-domain "http://ychubachi.github.io/")
 '(org-agenda-files
   (quote
    ("/home/yc/Dropbox/Org/bookmark.org" "/home/yc/Dropbox/Org/enpit.org" "/home/yc/Dropbox/Org/from-mobile.org" "/home/yc/Dropbox/Org/journal.org" "/home/yc/Dropbox/Org/notes.org" "/home/yc/Dropbox/Org/todo.org")))
 '(org-export-in-background nil)
 '(org-log-done (quote time))
 '(org-src-fontify-natively t)
 '(org2blog/wp-blog-alist
   (quote
    (("blog.chubachi.net" :url "http://blog.chubachi.net/xmlrpc.php" :username "yc" :password "6mX6fj4p2kZZ"))))
 '(outline-minor-mode-prefix "")
 '(send-mail-function (quote smtpmail-send-it))
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-z")
 '(shell-pop-window-size 30)
 '(show-paren-mode t)
 '(smtpmail-smtp-user "yoshihide.chubachi@gmail.com")
 '(user-full-name "Yoshihide Chubachi")
 '(user-mail-address "yc@aiit.ac.jp"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal))))
 '(org-column-title ((t (:background "grey30" :underline t :weight bold :height 135)))))
