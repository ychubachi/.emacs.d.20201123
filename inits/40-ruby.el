;;; 40-ruby.el --- Ruby development
;;; Commentary:
;; Preludeのモジュールとして次のものを有効にしています．
;; - coffee, js, ruby, scss


;; S式から正規表現を作成する - by shigemk2
;; - http://d.hatena.ne.jp/shigemk2/20120419/1334762456

;; EmacsでRubyの開発環境をめちゃガチャパワーアップしたまとめ | Futurismo
;; http://hmi-me.ciao.jp/wordpress/archives/1295

;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(flymake-ruby
		   flymake-haml
		   flymake-sass
		   flymake-coffee
		   smart-compile))
  (when (not (package-installed-p package))
    (package-install package)))

(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(require 'ruby-mode)

;; ================================================================
;; Ruby DSLs
;; ================================================================

(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))  
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))

;; ================================================================
;; outline-minnor-mode
;; ================================================================

(require 'outline)
(add-hook 'ruby-mode-hook
          (function
           (lambda ()
             (defun ruby-outline-level ()
               (or (and (match-string 1)
                        (or (cdr (assoc (match-string 1) outline-heading-alist))
                            (- (match-end 1) (match-beginning 1))))
                   (cdr (assoc (match-string 0) outline-heading-alist))
                   (- (match-end 0) (match-beginning 0))))

             (set (make-local-variable 'outline-level) 'ruby-outline-level)

             (set (make-local-variable 'outline-regexp)
                  (rx (group (* " "))
                      bow
                      (or "begin" "case" "class" "def" "else" "elsif"
                          "ensure" "if" "module" "rescue" "when" "unless"
                          "private")
                      eow))
             (outline-minor-mode))))

(add-hook 'rspec-mode-hook
          (function
           (lambda ()
             (defun rspec-outline-level ()
               (or (and (match-string 1)
                        (or (cdr (assoc (match-string 1) outline-heading-alist))
                            (- (match-end 1) (match-beginning 1))))
                   (cdr (assoc (match-string 0) outline-heading-alist))
                   (- (match-end 0) (match-beginning 0))))

             (set (make-local-variable 'outline-level) 'rspec-outline-level)

             (set (make-local-variable 'outline-regexp)
                  (rx (group (* " "))
                      bow
                      (or "context" "describe" "it" "subject")
                      eow))
             (outline-minor-mode))))

;; ================================================================
;; flymake関係
;; ================================================================

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'flymake-haml)
(add-hook 'haml-mode-hook 'flymake-haml-load)

(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)

(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

;; ================================================================
;; Use the right Ruby with Emacs and rbenv - Fist of Senn
;; - http://blog.senny.ch/blog/2013/02/11/use-the-right-ruby-with-emacs-and-rbenv/
;; ================================================================
;; (prelude-require-package 'rbenv)

;; ;; Setting rbenv path
;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;                        (getenv "HOME") "/.rbenv/bin:"
;;                        (getenv "PATH")))
;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; ================================================================
;; 賢いコンパイル
;; ================================================================

(require 'smart-compile)

(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;; ================================================================
;; Emacsで保存時にFirefoxのタブを探してリロード - Qiita [キータ]
;; - http://qiita.com/hakomo/items/9a99115f8911b55957bb
;; ================================================================
(require 'moz)

(defun my/reload-firefox ()
  "Reload firefox."
  (interactive)
  (comint-send-string (inferior-moz-process) "BrowserReload();"))

(defun my/run-rake-yard ()
  "Run rake yard."
  (interactive)
  (shell-command "rake yard"))

(define-key ruby-mode-map (kbd "C-c y") (lambda ()
                                          (interactive)
                                          (my/run-rake-yard)
                                          (my/reload-firefox)))

;;; 40-ruby.el ends here
