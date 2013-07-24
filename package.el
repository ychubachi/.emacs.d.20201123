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
(when (not package-archive-contents)
  (package-refresh-contents))
