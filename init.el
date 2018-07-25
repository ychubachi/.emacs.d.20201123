;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; ロードパスの設定

;; normal-top-level-add-subdirs-to-load-path は
;; default-directory の全てのサブディレクトリを load-path に追加する
;; 関数です．

;;; gitのsubmoduleとして管理するライブラリを追加します．
(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

;;; ソースコードで管理するライブラリを追加します．
(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;;; init-loaderの起動
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits/")

;;; costomize-variablesを別ファイルに記録
(setq custom-file (locate-user-emacs-file "custom.el"))
