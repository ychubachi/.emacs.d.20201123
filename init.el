;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Author: Y.Chubachi （中鉢 欣秀）
;; Created: 2013-06-04
;; Updated: 2013-06-26
;;
;; Thanks: http://qiita.com/items/5f1cd86e2522fd3384a0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load-pathの設定
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "site-lisp" "git")

;; packageの初期設定
(require 'package)
(setq package-user-dir "~/.emacs.d/packages/")
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; init-loaderの初期設定
(when (not (package-installed-p 'init-loader))
  (package-refresh-contents)
  (package-install 'init-loader))	;パッケージがなければインストール
(require 'init-loader)
;(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
