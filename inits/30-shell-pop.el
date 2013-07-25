;; パッケージのインストール
(setq package-list '(shell-pop))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;;
;; shell-pop
;; - 詳細設定はM-x customize-group RET sholl-pop RET
;;
(require 'shell-pop)
