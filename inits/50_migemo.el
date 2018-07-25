;;; migemo

;; ローマ字で日本語をインクリメンタルサーチ

;; - 注意
;;   - cmigemoコマンドがインストールされていること．
;;   - locate migemo-dictで辞書の場所調べ，設定してください．
;; - 参考
;;   - https://github.com/emacs-jp/migemo
;;   - [[http://qiita.com/catatsuy/items/c5fa34ead92d496b8a51][migemoを使ってEmacsライフを快適に - Qiita {キータ}]]

(use-package migemo
  :if (executable-find "cmigemo")
  :init
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  (setq migemo-command "cmigemo")
  (cond
   ((eq system-type 'gnu/linux)
    (setq migemo-dictionary
	  "/usr/share/cmigemo/utf-8/migemo-dict"))
   ((eq system-type 'darwin)
    (setq migemo-dictionary
	  "/usr/local/share/migemo/utf-8/migemo-dict"))
   ((eq system-type 'windows-nt)
    (setq migemo-dictionary
	  "/opt/cmigemo-default-win64/dict/utf-8/migemo-dict")))
  :ensure t)
