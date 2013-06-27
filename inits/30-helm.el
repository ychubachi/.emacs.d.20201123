;; パッケージのインストール
(setq package-list '(helm))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "C-c h") 'helm-mini)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
