;; パッケージのインストール
(setq package-list '(scss-mode flymake-sass))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; scss
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode))
(add-hook 'scss-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (define-key haml-mode-map "\C-m" 'newline-and-indent)))
(setq scss-compile-at-save nil) ; 保存時自動コンパイルしない

;; sass/scssモードでauto-complete-modeを有効にする
(add-to-list 'ac-modes 'sass-mode)
(add-to-list 'ac-modes 'scss-mode)

;;
;; flymake-sass
;;
(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)
