;;; Ruby開発

(package-initialize)
;; (package-install 'use-package)
(require 'use-package)

;;; HAML
(use-package haml-mode
  :mode ("\\.haml?\\'" . haml-mode)
  :config
  (progn
    (use-package flymake-haml)
    (add-hook 'haml-mode-hook 'flymake-haml-load)))


;;; flymake

;;   (require 'flymake-ruby)
;;  (add-hook 'ruby-mode-hook 'flymake-ruby-load)
;;


;;   (require 'flymake-sass)
;;   (add-hook 'sass-mode-hook 'flymake-sass-load)

;;   (require 'flymake-coffee)
;;   (add-hook 'coffee-mode-hook 'flymake-coffee-load)

;; * Ruby
;;   ;; S式から正規表現を作成する - by shigemk2
;;   ;; - http://d.hatena.ne.jp/shigemk2/20120419/1334762456

;;   ;; EmacsでRubyの開発環境をめちゃガチャパワーアップしたまとめ | Futurismo
;;   ;; http://hmi-me.ciao.jp/wordpress/archives/1295

;;   ;;; Code:

;;   ;; ================================================================
;;   ;; パッケージのインストール
;;   ;; ================================================================

;; #+begin_src emacs-lisp
;;   (autoload 'ruby-mode "ruby-mode"
;; 	"Mode for editing ruby source files" t)
;;   (require 'ruby-mode)

;;   ;; ================================================================
;;   ;; outline-minnor-mode
;;   ;; ================================================================

;;   (require 'outline)
;;   (add-hook 'ruby-mode-hook
;; 		(function
;; 		 (lambda ()
;; 		   (defun ruby-outline-level ()
;; 		 (or (and (match-string 1)
;; 			  (or (cdr (assoc (match-string 1) outline-heading-alist))
;; 				  (- (match-end 1) (match-beginning 1))))
;; 			 (cdr (assoc (match-string 0) outline-heading-alist))
;; 			 (- (match-end 0) (match-beginning 0))))

;; 		   (set (make-local-variable 'outline-level) 'ruby-outline-level)

;; 		   (set (make-local-variable 'outline-regexp)
;; 			(rx (group (* " "))
;; 			bow
;; 			(or "begin" "case" "class" "def" "else" "elsif"
;; 				"ensure" "if" "module" "rescue" "when" "unless"
;; 				"private")
;; 			eow))
;; 		   (outline-minor-mode))))

;;   (add-hook 'rspec-mode-hook
;; 		(function
;; 		 (lambda ()
;; 		   (defun rspec-outline-level ()
;; 		 (or (and (match-string 1)
;; 			  (or (cdr (assoc (match-string 1) outline-heading-alist))
;; 				  (- (match-end 1) (match-beginning 1))))
;; 			 (cdr (assoc (match-string 0) outline-heading-alist))
;; 			 (- (match-end 0) (match-beginning 0))))

;; 		   (set (make-local-variable 'outline-level) 'rspec-outline-level)

;; 		   (set (make-local-variable 'outline-regexp)
;; 			(rx (group (* " "))
;; 			bow
;; 			(or "context" "describe" "it" "subject")
;; 			eow))
;; 		   (outline-minor-mode))))

;;   ;; ================================================================
;;   ;; Use the right Ruby with Emacs and rbenv - Fist of Senn
;;   ;; - http://blog.senny.ch/blog/2013/02/11/use-the-right-ruby-with-emacs-and-rbenv/
;;   ;; ================================================================
;;   ;; (prelude-require-package 'rbenv)

;;   ;; ;; Setting rbenv path
;;   ;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;   ;;                        (getenv "HOME") "/.rbenv/bin:"
;;   ;;                        (getenv "PATH")))
;;   ;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;   ;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;;   ;; ================================================================
;;   ;; 賢いコンパイル
;;   ;; ================================================================

;;   (require 'smart-compile)

;;   (define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
;;   (define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;;   (setq smart-compile-alist
;; 	(quote ((emacs-lisp-mode emacs-lisp-byte-compile)
;; 		(html-mode browse-url-of-buffer)
;; 		(nxhtml-mode browse-url-of-buffer)
;; 		(html-helper-mode browse-url-of-buffer)
;; 		(octave-mode run-octave)
;; 		("\\.c\\'" . "gcc -O2 %f -lm -o %n")
;; 		("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
;; 		("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
;; 		("\\.java\\'" . "javac %f")
;; 		("\\.php\\'" . "php -l %f")
;; 		("\\.f90\\'" . "gfortran %f -o %n")
;; 		("\\.[Ff]\\'" . "gfortran %f -o %n")
;; 		("\\.cron\\(tab\\)?\\'" . "crontab %f")
;; 		("\\.tex\\'" tex-file)
;; 		("\\.texi\\'" . "makeinfo %f")
;; 		("\\.mp\\'" . "mptopdf %f")
;; 		("\\.pl\\'" . "perl -cw %f")
;; 		("\\.rb\\'" . "bundle exec ruby %f"))))

;;   ;; ================================================================
;;   ;; Emacsで保存時にFirefoxのタブを探してリロード - Qiita [キータ]
;;   ;; - http://qiita.com/hakomo/items/9a99115f8911b55957bb
;;   ;; ================================================================
;;   (require 'moz)

;;   (defun my/reload-firefox ()
;; 	"Reload firefox."
;; 	(interactive)
;; 	(comint-send-string (inferior-moz-process) "BrowserReload();"))

;;   (defun my/run-rake-yard ()
;; 	"Run rake yard."
;; 	(interactive)
;; 	(shell-command "rake yard"))

;;   (define-key ruby-mode-map (kbd "C-c y") (lambda ()
;; 						(interactive)
;; 						(my/run-rake-yard)
;; 						(my/reload-firefox)))
;; #+end_src
