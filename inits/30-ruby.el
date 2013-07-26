;; for ruby
;
; http://hmi-me.ciao.jp/wordpress/archives/1295

;; パッケージのインストール
(setq package-list '(flymake-ruby ruby-end smart-compile rspec-mode))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ruby-mode
;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; flymake-ruby
;;
(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; smart-compile
;;
(require 'smart-compile)

; コンパイル前に自動保存
(setq compilation-ask-about-save nil)

; コンパイルコマンドを修正
(add-to-list 'smart-compile-alist '("\\.rb\\'" . "ruby %f"))

; キーバインドを設定
(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; rspec-mode
;;
(require 'rspec-mode)
(add-hook 'dired-mode-hook 'rspec-dired-mode)

;; 2013-07-26 下記設定をしても，Launcherから起動したときはうまくいきません
(defadvice rspec-compile (around rspec-compile-around)
  "Use BASH shell for running the specs because of ZSH issues."
  (let ((shell-file-name "/bin/bash"))
    ad-do-it))
(ad-activate 'rspec-compile)

;; END
