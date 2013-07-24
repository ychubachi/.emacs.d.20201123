;; # パッケージ
;;   migemo
;; # 概要
;;   ローマ字で日本語をインクリメンタルサーチできるようにする．
;; # 注意
;; * cmigemoコマンドがインストールされていること．
;; * locate migemo-dictで辞書の場所調べ，設定してください．
;; # 参考
;; * https://github.com/emacs-jp/migemo

;; パッケージのインストール
(setq package-list '(migemo))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")
(migemo-init)
