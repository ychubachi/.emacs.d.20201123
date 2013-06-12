;; for ruby
;
; http://hmi-me.ciao.jp/wordpress/archives/1295
					;

; (require 'ruby-end)
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (abbrev-mode 1)
	     (electric-pair-mode t)
	     (electric-indent-mode t)
	     (electric-layout-mode t)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (add-to-list 'ruby-encoding-map '(undecided . utf-8))))

; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))  

(require 'ruby-electric)  
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))  
(setq ruby-electric-expand-delimiters-list nil)

(require 'ruby-block)  
(ruby-block-mode t)  
(setq ruby-block-highlight-toggle t)

(when (require 'rcodetools nil t)
  (define-key ruby-mode-map (kbd "<C-return>") 'rct-complete-symbol))

