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
