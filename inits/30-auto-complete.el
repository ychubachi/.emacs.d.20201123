;; パッケージのインストール
(setq package-list '(auto-complete))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; auto-complete
(require 'auto-complete-config)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
