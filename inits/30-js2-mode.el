;; パッケージのインストール
(setq package-list '(js2-mode))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; json
(setq auto-mode-alist
      (cons (cons "\\.json$" 'js2-mode) auto-mode-alist))
