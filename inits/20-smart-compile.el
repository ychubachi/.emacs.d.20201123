;; パッケージのインストール
(setq package-list '(smart-compile))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))
(require 'smart-compile)
