;; 最後に編集した場所へ移動します

;; パッケージのインストール
(setq package-list '(goto-last-change))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(global-set-key (kbd "C-x C-/") 'goto-last-change)
