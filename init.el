
;; init.el --- Emacsの初期設定

(message "Emacsの設定を開始します．")

(message "%% Emacsの設定を開始します %%")

(add-hook 'after-init-hook
          (lambda ()
            (message "%% Emacsの設定が完了しました %%")))

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

(setq debug-on-error t)

(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;; ================================================================
;; キーバインディング
;; ================================================================

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)

(global-auto-revert-mode 1)

(global-linum-mode t)
(set-face-attribute 'linum nil :foreground "yellow" :height 0.8)
(setq linum-format "%4d")

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(setq whitespace-action '(auto-cleanup))

;; ================================================================
;; 自作関数
;; ================================================================

(defun my/fullscreen ()
  (interactive)
  (set-frame-parameter
   nil
   'fullscreen
   (if (frame-parameter nil 'fullscreen)
       nil
     'fullboth)))

(defun my/open-init-folder()
  "設定フォルダを開きます．"
  (interactive)
  (find-file "~/.emacs.d/init.org"))

(defun my/open-journal()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/journal.org"))
  
(defun my/open-todo()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/todo.org"))

(defun my/open-note()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/index.org"))

(defun my/open-project-folder()
  "プロジェクトフォルダを開きます．"
  (interactive)
  (dired "~/git/"))

(global-set-key [f11] 'my/fullscreen)
(global-set-key (kbd "<f1>") 'my/open-init-folder)
(global-set-key (kbd "<f2>") 'my/open-journal)
(global-set-key (kbd "<f3>") 'my/open-todo)
(global-set-key (kbd "<f4>") 'my/open-note)
(global-set-key (kbd "<f5>") 'my/open-project-folder)

(cond
 ((eq system-type 'darwin)
  (let* ((size 14)
         (h (* size 10))
         (font-ascii "Ricty")
         (font-jp    "Ricty")
         (font-spec-ascii (font-spec :family font-ascii))
         (font-spec-jp    (font-spec :family font-jp)))
    (set-face-attribute 'default nil :family font-ascii :height h)
    (set-fontset-font nil 'japanese-jisx0208        font-spec-jp)
    (set-fontset-font nil 'japanese-jisx0212        font-spec-jp)
    (set-fontset-font nil 'japanese-jisx0213.2004-1 font-spec-jp)
    (set-fontset-font nil 'japanese-jisx0213-1      font-spec-jp)
    (set-fontset-font nil 'japanese-jisx0213-2      font-spec-jp)
    (set-fontset-font nil 'katakana-jisx0201        font-spec-jp)
    (set-fontset-font nil '(#x0080 . #x024F)        font-spec-ascii) 
    (set-fontset-font nil '(#x0370 . #x03FF)        font-spec-ascii))
  ))

(require 'package)
(setq package-archives
      '(("org" .       "http://orgmode.org/elpa/")
        ("gnu" .       "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" .     "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (package '(yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(dolist (package '(org org-plus-contrib))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'ox-md)

(require 'ox-mediawiki)

(require 'ox-latex)

(cond
 ((eq system-type 'gnu/linux)
  (setq org-latex-pdf-process '("latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
  )
 ((eq system-type 'darwin)
  (setq org-latex-pdf-process '("latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
  ))

(setq org-latex-default-class "jsarticle")
(add-to-list 'org-latex-classes
             '("jsarticle"
               "\\ifdefined\\ucs
  \\documentclass[uplatex,12pt,a4paper,papersize,dvipdfmx]{jsarticle}
\\else
  \\documentclass[12pt,a4paper,papersize,dvipdfmx]{jsarticle}
\\fi
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\usepackage{pxjahyper}
\\hypersetup{setpagesize=false,colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(require 'ox-beamer)

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass[dvipdfmx]{beamer}
[NO-DEFAULT-PACKAGES]
\\usepackage{bxdpx-beamer}
\\usepackage{pxjahyper}
\\usepackage{minijs}
\\renewcommand{\\kanjifamilydefault}{\\gtdefault}
\\AtBeginSection[]
{
  \\begin{frame}<beamer>{Outline}
  \\tableofcontents[currentsection,currentsubsection]
  \\end{frame}
}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-publish-project-alist
      '(
        ("chubachi.net-notes"
         :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
         :base-extension "org"
         :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
         :publishing-function org-html-publish-to-html
         ;; :headline-levels 3
         ;; :section-numbers nil
         ;; :with-toc nil
         ;; :html-head "<link rel=\"stylesheet\"
         ;;               href=\"../other/mystyle.css\" type=\"text/css\"/>"
         ;; :html-preamble t
         :recursive t
         )
        ("chubachi.net-static"
         :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("chubachi.net"
         :components ("chubachi.net-notes" "chubachi.net-static"))
      ))

(setq org-babel-sh-command "bash")

(dolist (package '(org2blog xml-rpc metaweblog htmlize))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'xml-rpc)
(require 'metaweblog)
(require 'org2blog-autoloads)

(setq org2blog/wp-blog-alist
      '(("blog.chubachi.net"
         :url "http://blog.chubachi.net/xmlrpc.php"
         :username "yc"
         :default-title "Emacs title"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
        ))

(dolist (package '(helm))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'helm-config)

(helm-mode 1)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

(setq helm-delete-minibuffer-contents-from-point t)

(dolist (package '(helm-descbinds
                   helm-migemo
                   helm-themes
                   imenu-anywhere
                   helm-c-yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'helm-command)
(require 'helm-descbinds)

(setq helm-idle-delay             0.1
      helm-input-idle-delay       0.1
      helm-candidate-number-limit 200)

(require 'helm-migemo)
(setq helm-use-migemo t)

(defadvice helm-c-apropos
  (around ad-helm-apropos activate)
  "候補が表示されないときがあるので migemoらないように設定."
  (let ((helm-use-migemo nil))
    ad-do-it))

(defadvice helm-M-x
  (around ad-helm-M-x activate)
  "候補が表示されないときがあるので migemoらないように設定."
  (let ((helm-use-migemo nil))
    ad-do-it))

;; ================================================================
;; その他
;; ================================================================
(require 'helm-imenu)
(setq imenu-auto-rescan t)
(setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

(require 'helm-themes)

(require 'helm-c-yasnippet)

;; ================================================================
;; package listをhelmで選択
;; (This package is installed in vendor directory.)
;; ================================================================
(require 'helm-package)

(dolist (package '(smartrep))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'smartrep)

(eval-after-load "org"
  '(progn
     (smartrep-define-key
         org-mode-map
         "C-c" '(("C-n" . (lambda ()
                            (outline-next-visible-heading 1)))
                 ("C-p" . (lambda ()
                            (outline-previous-visible-heading 1)))))))

(dolist (package '(markdown-mode))
  (when (not (package-installed-p package))
    (package-install package)))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-hook 'markdown-mode-hook
          '(lambda () (outline-minor-mode t)))

(dolist (package '(mediawiki))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'mediawiki)

(dolist (package '(graphviz-dot-mode))
  (when (not (package-installed-p package))
    (package-install package)))

(add-to-list 'auto-mode-alist '("\\.dot$" . graphviz-dot-mode))

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(region-bindings-mode key-chord))
  (when (not (package-installed-p package))
    (package-install package)))


;; ================================================================
;; グローバルマップの設定
;; ================================================================

;;; shell-pop
(global-set-key (kbd "C-z") 'shell-pop)

;;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ================================================================
;; グローバルマップの設定(org-mode)
;; ================================================================
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; ================================================================
;; グローバルマップの設定(helm)
;; ================================================================
(let ((key-and-func
       `(
         (,(kbd "M-x")     helm-M-x)
         (,(kbd "M-y")     helm-show-kill-ring)
         (,(kbd "C-x C-f") helm-find-files)
;;         (,(kbd "C-r")   helm-for-files)
;;         (,(kbd "C-^")   helm-c-apropos)
;;         (,(kbd "C-;")   helm-resume)
;;         (,(kbd "M-s")   helm-occur)
;;         (,(kbd "M-z")   helm-do-grep)
;;         (,(kbd "C-S-h") helm-descbinds)
         )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))

;; ================================================================
;; 個人用キーマップの設定
;; ================================================================
(defun my/other-window-backward ()
  "Move to other window backward."
  (interactive)
  (other-window -1))

(define-prefix-command 'personal-map)
(global-set-key (kbd "C-.") 'personal-map)

(define-key 'personal-map (kbd "C-n") 'other-window)
(define-key 'personal-map (kbd "C-p") 'my/other-window-backward)

(define-key 'personal-map (kbd "m") 'imenu)
(define-key 'personal-map (kbd "h") 'helm-mini)

(define-key 'personal-map (kbd "i") 'yas-insert-snippet)
(define-key 'personal-map (kbd "n") 'yas-new-snippet)
(define-key 'personal-map (kbd "v") 'yas-visit-snippet-file)

(define-key 'personal-map (kbd "y") 'helm-c-yas-complete)
(define-key 'personal-map (kbd "s") 'helm-c-yas-create-snippet-on-region)

(cond ((eq system-type 'gnu/linux)
       (define-key 'personal-map (kbd "p") 'evince-forward-search))
      ((eq system-type 'darwin)
       (define-key 'personal-map (kbd "p") 'skim-forward-search)))

;; ================================================================
;; リージョンがある間のキーバインディングを変更する
;; ================================================================

(require 'region-bindings-mode)
(region-bindings-mode-enable)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
(define-key region-bindings-mode-map "e" 'mc/edit-lines)
(setq region-bindings-mode-disabled-modes '(mew-summary-mode))

;; ================================================================
;; key-chordの設定をする
;; ================================================================
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "gc" 'my/other-window-backward)
(key-chord-define-global "cr" 'other-window)

(when (not (package-installed-p 'init-loader))
  (package-install 'init-loader))
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
; (setq init-loader-show-log-after-init nil)

(dolist (package '(magit))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'magit)

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(mew))
  (when (not (package-installed-p package))
    (package-install package)))

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; ================================================================
;; Mewの設定
;; ================================================================

; Stunnel
(setq mew-prog-ssl "/usr/bin/stunnel4")

; IMAP for Gmail
(setq mew-proto "%")
(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "yoshihide.chubachi@gmail.com")
(setq mew-imap-auth  t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "yoshihide.chubachi@gmail.com")
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-fcc "%[Gmail]/送信済みメール") ; 送信メイルを保存する
(setq mew-imap-trash-folder "%[Gmail]/すべてのメール")

(setq mew-use-cached-passwd t)
;(setq mew-use-master-passwd t)

(setq mew-ssl-verify-level 0)
;(setq mew-use-unread-mark t)

; w3m
(condition-case nil
    (require 'mew-w3m)
  (error (message "mew-w3m: Plase install w3m")))

; pdf viewer
(setq mew-prog-pdf '("evince" nil t))

(require 'migemo)

(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(cond
 ((eq system-type 'gnu/linux)
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
 ((eq system-type 'darwin)
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")))

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")
(migemo-init)

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(auto-complete multiple-cursors yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; 自動補間
;; ================================================================

(require 'auto-complete-config)
(ac-config-default)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; ================================================================
;; 複数のカーソルを扱う
;; ================================================================

(require 'multiple-cursors)

;; ================================================================
;; Emacs Lisp
;; ================================================================

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

(dolist (package '(shell-pop))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'shell-pop)

(dolist (package '(undo-tree))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'undo-tree)
(global-undo-tree-mode t)

(dolist (package '(w3m))
  (when (not (package-installed-p package))
    (condition-case nil
        (package-install package)
      (error (message "Please Install w3m command")))))

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

;; ================================================================
;; YaTeX - TeX Wiki
;; - http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#nec42ee2
;; ================================================================
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)

;; ================================================================
;; RefTeX with YaTeX
;; ================================================================
(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; ================================================================
;; Outline minor mode for YaTeX
;; See http://www.math.s.chiba-u.ac.jp/~matsu/emacs/emacs20/outline.html
;; ================================================================
(add-hook 'yatex-mode-hook
          '(lambda () (outline-minor-mode t)))

(make-variable-buffer-local 'outline-regexp)
(add-hook
 'yatex-mode-hook
 (function
  (lambda ()
    (progn
      (setq outline-level 'latex-outline-level)
      (setq outline-regexp
            (concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
                    "chapter\\|section\\|subsection\\|subsubsection\\)"
                    "\\*?[ \t]*[[{]")
     )))))

(make-variable-buffer-local 'outline-level)
(setq-default outline-level 'outline-level)
(defun latex-outline-level ()
  (save-excursion
    (looking-at outline-regexp)
    (let ((title (buffer-substring (match-beginning 1) (match-end 1))))
      (cond ((equal (substring title 0 4) "docu") 15)
            ((equal (substring title 0 4) "chap") 0)
            ((equal (substring title 0 4) "appe") 0)
            (t (length title))))))

;; ================================================================
;; BibTeX
;; ================================================================
(add-hook 'bibtex-mode-hook
          '(lambda ()
             (outline-minor-mode)))

;; ================================================================
;; IPA Fonts
;; ================================================================
(setq YaTeX-dvipdf-command "dvipdfmx -f ptex-ipa")

;; ================================================================
;; auto-fill-mode
;; ================================================================
(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode 1)))

;;; 80-clean-mode-line.el --- <description>
;;; Commentary:

;; mode-lineのモード情報をコンパクトに表示する- Life is very short
;; - http://d.hatena.ne.jp/syohex/20130131/1359646452

;;; Code:

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " Ys")
    (paredit-mode . " Pe")
    (eldoc-mode . "")
    (abbrev-mode . "")
    (undo-tree-mode . " Ut")
    (elisp-slime-nav-mode . " EN")
    (helm-gtags-mode . " HG")
    (flymake-mode . " Fm")
    (outline-minor-mode . " Ol")
    (ibus-mode . " IB")
    ;; Major modes
    (lisp-interaction-mode . "Li")
    (python-mode . "Py")
    (ruby-mode   . "Rb")
    (emacs-lisp-mode . "El")
    (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;;; 80-clean-mode-line.el ends here

;; ;; パッケージのインストール
;; (setq package-list '(buffer-move))
;; (dolist (package package-list)
;;   (when (not (package-installed-p package))
;;     (package-install package)))

;; ; buffer-move : have to add your own keys
;; (global-set-key (kbd "<C-S-up>")     'buf-move-up)
;; (global-set-key (kbd "<C-S-down>")   'buf-move-down)
;; (global-set-key (kbd "<C-S-left>")   'buf-move-left)
;; (global-set-key (kbd "<C-S-right>")  'buf-move-right)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;
;; ;; tabbar.el
;; ;;
;; ;; [Emacsにタブ機能を追加するtabbar.elの導入 - 12FF5B8](http://hico-horiuchi.hateblo.jp/entry/20121208/1354975316)

;; ;; パッケージのインストール
;; (setq package-list '(tabbar))
;; (dolist (package package-list)
;;   (when (not (package-installed-p package))
;;     (package-install package)))

;; (require 'tabbar)
;; (tabbar-mode)
;; (global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
;; (global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
;; ;; タブ上でマウスホイールを使わない
;; (tabbar-mwheel-mode nil)
;; ;; グループを使わない
;; (setq tabbar-buffer-groups-function nil)
;; ;; 左側のボタンを消す
;; (dolist (btn '(tabbar-buffer-home-button
;;                tabbar-scroll-left-button
;;                tabbar-scroll-right-button))
;;   (set btn (cons (cons "" nil)
;;                  (cons "" nil))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; NOT IN PACKAGE
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path "~/.rbenv/versions/2.0.0-p195/lib/ruby/gems/2.0.0/gems/rcodetools-0.8.5.0")

;; ;; rcodetools
;; (require 'rcodetools)
;; (setq rct-find-tag-if-available nil)
;; (defun ruby-mode-hook-rcodetools ()
;;   (define-key ruby-mode-map (kbd "<C-return>") 'rct-complete-symbol)
;;   (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
;;   (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
;;   (define-key ruby-mode-map "\C-c\C-d" 'xmp)
;;   (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

;; (setq rct-get-all-methods-command "PAGER=cat fri -l")
;; ;; See docs

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name custom-file))
    (load (expand-file-name custom-file)))

;バッファのフォントサイズを大きく
(global-set-key (kbd "<prior>") 'text-scale-increase)
;バッファのフォントサイズを小さく
(global-set-key (kbd "<next>")  'text-scale-decrease)

(message "init.elは完了しました")

;;; init.el ends here
