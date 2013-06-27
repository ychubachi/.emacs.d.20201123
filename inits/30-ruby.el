;; for ruby
;
; http://hmi-me.ciao.jp/wordpress/archives/1295

;; パッケージのインストール
(setq package-list '(flymake-ruby ruby-block ruby-electric rbenv))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))
;;
;; ruby-mode
;;
; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))  

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (abbrev-mode 1)
	     (electric-pair-mode t)
	     (electric-indent-mode t)
	     (electric-layout-mode t)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (add-to-list 'ruby-encoding-map '(undecided . utf-8))))

;;
;; flymake-ruby
;;
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;
;; ruby-electric
;; * do-end，カッコの補完
;;
(require 'ruby-electric)  
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))  
(setq ruby-electric-expand-delimiters-list nil)

;;
;; ruby-block
;;  endにカーソルを当てると，対応する行をハイライト
;;
(require 'ruby-block)  
(ruby-block-mode t)  
(setq ruby-block-highlight-toggle t)

;;
;; rbenv（設定不要）
;;
