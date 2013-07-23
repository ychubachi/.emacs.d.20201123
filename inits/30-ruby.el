;; for ruby
;
; http://hmi-me.ciao.jp/wordpress/archives/1295

;; パッケージのインストール
(setq package-list '(flymake-ruby ruby-end))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;;
;; ruby-mode
;;
; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (abbrev-mode 1)
	     (electric-pair-mode t)
	     (electric-indent-mode t)
	     (electric-layout-mode t)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (add-to-list 'ruby-encoding-map '(undecided . utf-8))))

;; endを補間します
(require 'ruby-end)

;;
;; flymake-ruby
;;
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;
;; smart-compile
;;
(require 'smart-compile)
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

(add-to-list 'smart-compile-alist '("\\.rb\\'" . "ruby %f"))
