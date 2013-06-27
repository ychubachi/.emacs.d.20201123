;; (require 'cl)

;; ;; ここに使っているパッケージを書く。
;; (defvar installing-package-list
;;   '(
;; ;;     auctex
;; ;;     color-theme		                ; nice looking emacs
;; ;;     dropdown-list
;; ;;     escreen            			; screen for emacs, C-\ C-h
;; ;;     flymake-easy
;; ;;     js2-mode
;; ;;     magithub
;; ;;     migemo
;; ;;     open-junk-file
;; ;;     php-mode
;; ;;     recentf-ext
;; ;;     redo+
;; ;;     switch-window			; takes over C-x o
;; ;;     yaml-mode
;; ;;     yasnippet
;; ;;     zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
;; ;;     smex
;; ;;     goto-last-change
;; ;;     buffer-move
;; ;;     multi-term
;; ;;     shell-pop
;;     ))

;; (let ((not-installed (loop for x in installing-package-list
;;                             when (not (package-installed-p x))
;;                             collect x)))
;;   (when not-installed
;;     (package-refresh-contents)
;;     (dolist (pkg not-installed)
;;         (package-install pkg))))
