;; mewのインストール
(setq package-name 'magit)

;; パッケージがなければインストール
(when (not (package-installed-p package-name))
  (package-install package-name))

;; Magit
(require 'magit)
(global-set-key (kbd "M-v") 'magit-status) ;; override
