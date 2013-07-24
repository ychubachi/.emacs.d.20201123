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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; init-loaderの設定
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
