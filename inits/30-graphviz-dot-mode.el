;; パッケージのインストール
(setq package-list '(graphviz-dot-mode))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(setq auto-mode-alist
      (append '(("\\.dot$" . graphviz-dot-mode))))

