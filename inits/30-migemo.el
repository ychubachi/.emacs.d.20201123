;; ================================================================
;; ローマ字で日本語をインクリメンタルサーチ
;; ================================================================
;;
;; # 注意
;; * cmigemoコマンドがインストールされていること．
;; * locate migemo-dictで辞書の場所調べ，設定してください．
;; # 参考
;; * https://github.com/emacs-jp/migemo

(require 'migemo)

(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(cond ((eq system-type 'gnu/linux)
       (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
      ((eq system-type 'darwin)
       (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")))

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")
(migemo-init)
