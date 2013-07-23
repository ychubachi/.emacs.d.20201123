;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Author: Y.Chubachi （中鉢 欣秀）
;; Created: 2013-06-04
;; Updated: 2013-06-26
;;
;; Thanks: http://qiita.com/items/5f1cd86e2522fd3384a0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; load-pathの設定
;;
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "site-lisp" "git")

;;
;; packageの初期設定
;;
(require 'package)

;; ディレクトリの設定
(setq package-user-dir "~/.emacs.d/packages/")

;; リポジトリの設定
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; 全てのパッケージをアーカイブ
(package-initialize)

;; アーカイブがなければ取得
(when (not package-archive-contents)
  (package-refresh-contents))

;;
;; init-leaderの設定
;;

;; init-loaderのインストール
(setq package-name 'init-loader)

;; パッケージがなければインストール
(when (not (package-installed-p package-name))
  (package-install package-name))

;; init-loaderの初期化
(require 'init-loader)
;(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-inits()        ; 対話的版
  "自分の設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/inits"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shell-pop-shell-type (quote ("multi-term" "*terminal<1>*" (quote (lambda nil (multi-term))))))
 '(shell-pop-universal-key "C-z"))
