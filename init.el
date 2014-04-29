
;; init.el --- Emacsの初期設定

(message "%s" "%% Emacsの設定を開始します %%")

(add-hook 'after-init-hook
          (lambda ()
            (setq custom-file "~/.emacs.d/custom.el")
            (if (file-exists-p (expand-file-name custom-file))
                (load (expand-file-name custom-file)))
            (message "%s" "%% custom.elを読み込みました %%")))

(load "server")
(unless (server-running-p)
  (server-start))

(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(setq auto-save-file-name-transforms
      (quote ((".*" "~/.emacs.d/data/backup/" t))))
(setq backup-directory-alist
      (quote (("\\.*$" . "~/.emacs.d/data/backup"))))

(setq bookmark-default-file
      "~/.emacs.d/data/bookmarks")

(global-auto-revert-mode 1)

(setq inhibit-startup-screen t)

(setq auto-save-list-file-prefix
      "~/data/auto-save-list/.saves-")

(show-paren-mode 1)

(add-hook 'before-save-hook
 'whitespace-cleanup)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(column-number-mode t)

(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time-mode 1)

(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal)))))

(setq mouse-yank-at-point t)

(setq mouse-drag-copy-region t)

(setq compilation-ask-about-save nil)

(setq outline-minor-mode-prefix "")

(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)

;バッファのフォントサイズを大きく
(global-set-key (kbd "<prior>") 'text-scale-increase)
;バッファのフォントサイズを小さく
(global-set-key (kbd "<next>")  'text-scale-decrease)

(require 'package)
(setq package-archives
      '(("org" .       "http://orgmode.org/elpa/")
        ("gnu" .       "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" .     "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defun my/package-install (package-symbol)
  (unless (package-installed-p package-symbol)
    (package-install package-symbol)))

(defun my/package-install-and-require (package-symbol)
  (my/package-install package-symbol)
  (require package-symbol))

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

;; (cond
;;  ((eq system-type 'darwin)
;;   (let* ((size 14)
;;          (h (* size 10))
;;          (font-ascii "Ricty")
;;          (font-jp    "Ricty")
;;          (font-spec-ascii (font-spec :family font-ascii))
;;          (font-spec-jp    (font-spec :family font-jp)))
;;     (set-face-attribute 'default nil :family font-ascii :height h)
;;     (set-fontset-font nil 'japanese-jisx0208        font-spec-jp)
;;     (set-fontset-font nil 'japanese-jisx0212        font-spec-jp)
;;     (set-fontset-font nil 'japanese-jisx0213.2004-1 font-spec-jp)
;;     (set-fontset-font nil 'japanese-jisx0213-1      font-spec-jp)
;;     (set-fontset-font nil 'japanese-jisx0213-2      font-spec-jp)
;;     (set-fontset-font nil 'katakana-jisx0201        font-spec-jp)
;;     (set-fontset-font nil '(#x0080 . #x024F)        font-spec-ascii)
;;     (set-fontset-font nil '(#x0370 . #x03FF)        font-spec-ascii))
;;   ))

(add-hook 'input-method-activate-hook
          '(lambda () (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
          '(lambda () (set-cursor-color "orchid")))

(when (eq system-type 'gnu/linux)
  (require 'mozc)
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "C-o") 'toggle-input-method)
  (setq mozc-candidate-style 'overlay))

(my/package-install-and-require 'open-junk-file)
(global-set-key (kbd "C-x C-z") 'open-junk-file)

(my/package-install-and-require 'lispxmp)                 ; =>
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp) ; =>

(my/package-install-and-require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(show-paren-mode 1)

(find-function-setup-keys)

(my/package-install-and-require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(dolist (package '(yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

(unless (executable-find "cmigemo")
  (warn "！！ 警告：cmigemoコマンドが呼び出せません　！！"))

(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-options '("-q" "--emacs"))

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)

  (setq migemo-command "cmigemo")

  (cond
   ((eq system-type 'gnu/linux)
    (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
   ((eq system-type 'darwin)
    (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")))
  )

(dolist (package '(org org-plus-contrib))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'org)

(setq org-directory "~/Dropbox/Org")
(setq org-agenda-files (quote ("~/Dropbox/Org/")))
(setq org-default-notes-file "notes.org")

(setq org-capture-templates
        (quote
         (("t" "Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO [#B] %?
SCHEDULED: %t
")
          ("l" "Link as Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO [#B] %a
SCHEDULED: %t
　引用: %i
%?
")
          ("j" "Journal" entry (file+datetree "journal.org")
           "* %?
作成日: %U
　引用: %i
リンク: %a
")
          ("b" "Bookmark" entry (file+headline "bookmark.org" "Bookmarks")
           "* TODO [#B] %a :bookmark:
SCHEDULED: %t
　引用: %i
%?
")
          )))

(setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
(setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")

(setq org-babel-load-languages
      (quote
       ((emacs-lisp . t)
        (dot . t)
        (java . t)
        (ruby . t)
        (sh . t))))

(setq org-confirm-babel-evaluate nil)

(setq org-agenda-custom-commands
      (quote
       (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
        ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
        ("p" "私用" tags-todo "+私用" nil)
        ("P" "私用以外" tags-todo "-私用" nil)
        ("n" "Agenda and all TODO's" ((agenda "" nil)
                                      (alltodo "" nil)) nil))))

(setq org-todo-keywords (quote ((sequence "TODO(t)" "WIP(p)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)" "CANCEL(c)"))))

(setq org-deadline-warning-days 7)

(define-key org-mode-map "\M-q" 'toggle-truncate-lines)

(custom-set-variables
 '(org-export-in-background nil)
 '(org-src-fontify-natively t))

(setq org-babel-sh-command "bash")

(require 'ox-md)

(require 'ox-mediawiki)

(require 'ox-latex)

(when (or
       (eq system-type 'gnu/linux)
       (eq system-type 'darwin))
  (setq org-latex-pdf-process
        '("latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
  )

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

(setq org2blog/wp-use-sourcecode-shortcode t)

(custom-set-faces
 '(org-column-title
   ((t (:background "grey30" :underline t :weight bold :height 135)))))

(require 'org-protocol)

(my/package-install 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-mini)

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

(when (executable-find "cmigemo")
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
  )

(require 'helm-imenu)
(setq imenu-auto-rescan t)
(setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

(require 'helm-themes)

(require 'helm-c-yasnippet)

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
                            (outline-previous-visible-heading 1)))))
     ))

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

(setq graphviz-dot-preview-extension "pdf")

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

(global-set-key [f11] 'my/fullscreen)
(global-set-key (kbd "<f1>") 'my/open-init-folder)

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(region-bindings-mode key-chord))
  (when (not (package-installed-p package))
    (package-install package)))


;; ================================================================
;; グローバルマップの設定
;; ================================================================

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

(define-key 'personal-map (kbd "b") 'org-beamer-export-to-pdf)

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

(dolist (package '(magit))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'magit)

(defun email ()
  (interactive)

  (when (not (featurep 'mu4e))
    (add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")

    (require 'mu4e)
    (require 'org-mu4e)

    (setq mu4e-maildir       "~/Maildir")
    (setq mu4e-drafts-folder "/[Gmail].Drafts")
    (setq mu4e-trash-folder  "/[Gmail].Trash")
    (setq mu4e-sent-folder   "/[Gmail].All Mail")

    ;; don't save message to Sent Messages, Gmail/IMAP takes care of this
    (setq mu4e-sent-messages-behavior 'delete)

    ;; setup some handy shortcuts
    ;; you can quickly switch to your Inbox -- press ``ji''
    ;; then, when you want archive some messages, move them to
    ;; the 'All Mail' folder by pressing ``ma''.
    (setq mu4e-maildir-shortcuts
          '( ("/INBOX"             . ?i)
             ("/[Gmail].All Mail"  . ?a)
             ("/[Gmail].Drafts"    . ?d)
             ("/[Gmail].Trash"     . ?t)))

    ;; allow for updating mail using 'U' in the main view:
    ;; I have this running in the background anyway
    ;; (setq mu4e-get-mail-command "offlineimap")

    (require 'smtpmail)
    (setq message-send-mail-function 'smtpmail-send-it
          smtpmail-stream-type 'starttls
          smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587)

    ;; don't keep message buffers around
    (setq message-kill-buffer-on-exit t)

    ;; show images
    (setq mu4e-show-images t)

    ;; use imagemagick, if available
    (when (fboundp 'imagemagick-register-types)
      (imagemagick-register-types))

    (setq mu4e-msg2pdf "/usr/bin/msg2pdf")

    (add-to-list 'mu4e-view-actions
                 '("View in browser" . mu4e-action-view-in-browser) t)

    ;; convert org mode to HTML automatically
    (setq org-mu4e-convert-to-html t)

    ;; need this to convert some e-mails properly
    (setq mu4e-html2text-command "html2text -utf8 -width 72")

    (add-to-list 'mu4e-bookmarks '("flag:flagged" "Starred" ?s))
    )
  (mu4e)
  )

(defalias 'org-mail 'org-mu4e-compose-org-mode)

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(multiple-cursors yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))

(my/package-install 'auto-complete)
(require 'auto-complete-config)
(eval-after-load "auto-complete-config"
  '(progn
     (message "%s" "%% auto-complete-configを読み込みました. %%")
     (ac-config-default)
     (setq ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")
     (define-key ac-complete-mode-map "\C-n" 'ac-next)
     (define-key ac-complete-mode-map "\C-p" 'ac-previous)))

(require 'multiple-cursors)

;; ================================================================
;; Emacs Lisp
;; ================================================================

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

(my/package-install-and-require 'shell-pop)

(custom-set-variables
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-z")
 '(shell-pop-window-height 30))

(dolist (package '(undo-tree))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'undo-tree)
(global-undo-tree-mode t)

(dolist (package '(w3m))
  (when (not (package-installed-p package))
    (condition-case nil
        (package-install package)
      (error (message "%s" "Please Install w3m command")))))

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

(setq smart-compile-alist
      (quote ((emacs-lisp-mode emacs-lisp-byte-compile)
              (html-mode browse-url-of-buffer)
              (nxhtml-mode browse-url-of-buffer)
              (html-helper-mode browse-url-of-buffer)
              (octave-mode run-octave)
              ("\\.c\\'" . "gcc -O2 %f -lm -o %n")
              ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
              ("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
              ("\\.java\\'" . "javac %f")
              ("\\.php\\'" . "php -l %f")
              ("\\.f90\\'" . "gfortran %f -o %n")
              ("\\.[Ff]\\'" . "gfortran %f -o %n")
              ("\\.cron\\(tab\\)?\\'" . "crontab %f")
              ("\\.tex\\'" tex-file)
              ("\\.texi\\'" . "makeinfo %f")
              ("\\.mp\\'" . "mptopdf %f")
              ("\\.pl\\'" . "perl -cw %f")
              ("\\.rb\\'" . "bundle exec ruby %f"))))

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

(dolist (package '(php-mode))
  (when (not (package-installed-p package))
    (package-install package)))

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

(global-set-key (kbd "C-x C-b") 'ibuffer)

(when (eq system-type 'gnu/linux)

  (setq YaTeX-dvi2-command-ext-alist
        '(("texworks\\|evince\\|okular\\|zathura\\|qpdfview\\|pdfviewer\\|mupdf\\|xpdf\\|firefox\\|chromium\\|acroread\\|pdfopen" . ".pdf")))
  (setq tex-command "ptex2pdf -l -ot '-synctex=1'")
;;(setq tex-command "ptex2pdf -l -u -ot '-synctex=1'")
;;(setq tex-command "pdfplatex")
;;(setq tex-command "pdfplatex2")
;;(setq tex-command "pdfuplatex")
;;(setq tex-command "pdfuplatex2")
;;(setq tex-command "pdflatex -synctex=1")
;;(setq tex-command "lualatex -synctex=1")
;;(setq tex-command "luajitlatex -synctex=1")
;;(setq tex-command "xelatex -synctex=1")
;;(setq tex-command "latexmk")
;(setq tex-command "latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -g > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
;(setq tex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
;(setq tex-command "latexmk -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -e '$bibtex=q/bibtex %O %B/' -e '$makeindex=q/makeindex %O -o %D %S/' -norc -gg -pdf")
;(setq tex-command "latexmk -e '$pdflatex=q/lualatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
;(setq tex-command "latexmk -e '$pdflatex=q/luajitlatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
;(setq tex-command "latexmk -e '$pdflatex=q/xelatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -xelatex")
(setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex")
                           ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "bibtexu")
                           ((string-match "pdflatex\\|latex" tex-command) "bibtex")
                           (t "pbibtex")))
(setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "mendex")
                              ((string-match "platex" tex-command) "mendex")
                              ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "texindy")
                              ((string-match "pdflatex\\|latex" tex-command) "makeindex")
                              (t "mendex")))

(setq dvi2-command "evince")
;(setq dvi2-command "okular --unique")
;(setq dvi2-command "zathura -s -x \"emacsclient --no-wait +%{line} %{input}\"")
;(setq dvi2-command "qpdfview --unique")
;(setq dvi2-command "pdfviewer")
;(setq dvi2-command "texworks")
;(setq dvi2-command "mupdf")
;(setq dvi2-command "firefox -new-window")
;(setq dvi2-command "chromium --new-window")
(setq dviprint-command-format "acroread `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")

(defun evince-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "fwdevince"
      nil
      "fwdevince"
      (expand-file-name
       (concat (file-name-sans-extension (or YaTeX-parent-file
                                             (save-excursion
                                               (YaTeX-visit-main t)
                                               buffer-file-name)))
               ".pdf"))
      (number-to-string (save-restriction
                          (widen)
                          (count-lines (point-min) (point))))
      (buffer-name)))))

(require 'dbus)

(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))

(defun evince-inverse-search (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(dbus-register-signal
 :session nil "/org/gnome/evince/Window/0"
 "org.gnome.evince.Window" "SyncSource"
 'evince-inverse-search)

(defun okular-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "okular"
      nil
      "okular"
      "--unique"
      (concat (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              (buffer-file-name))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c o") 'okular-forward-search)))

(defun qpdfview-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "qpdfview"
      nil
      "qpdfview"
      "--unique"
      (concat (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (buffer-name)
              ":"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              ":0")))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c q") 'qpdfview-forward-search)))

(defun pdfviewer-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "pdfviewer"
      nil
      "pdfviewer"
      (concat "file:"
              (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              " "
              (buffer-name))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c p") 'pdfviewer-forward-search)))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))
)

(when (eq system-type 'gnu/linux)
  (require 'dbus)

  (defun un-urlify (fname-or-url)
    "A trivial function that replaces a prefix of file:/// with just /."
    (if (string= (substring fname-or-url 0 8) "file:///")
        (substring fname-or-url 7)
      fname-or-url))

  (defun evince-inverse-search (file linecol &rest ignored)
    (let* ((fname (un-urlify file))
           (buf (find-file fname))
           (line (car linecol))
           (col (cadr linecol)))
      (if (null buf)
          (message "[Synctex]: %s is not opened..." fname)
        (switch-to-buffer buf)
        (goto-line (car linecol))
        (unless (= col -1)
          (move-to-column col)))))

  (when (boundp 'dbus-message-type-method-call) nil t
        (dbus-register-signal
         :session nil "/org/gnome/evince/Window/0"
         "org.gnome.evince.Window" "SyncSource"
         'evince-inverse-search))
  )

(when (eq system-type 'darwin)
  ;; option <-> meta
  (setq ns-command-modifier (quote meta))
  (setq ns-alternate-modifier (quote super))
  
  ;; システムへ修飾キーを渡さない
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  (setq mac-pass-option-to-system nil)
  
  ;;; C-oで日本語切り替え
  (mac-input-method-mode t)
  (global-set-key "\C-o" 'toggle-input-method)
  
  ;; かな
  (mac-set-input-method-parameter
   "com.google.inputmethod.Japanese.base" 'cursor-color 'green)
  
  ;; 英数字
  (mac-set-input-method-parameter
   "com.google.inputmethod.Japanese.Roman" 'cursor-color 'red)
  
  ;; change cursor type
  (mac-set-input-method-parameter
   "com.google.inputmethod.Japanese.base" 'cursor-type 'box)
  ;; ================================================================
  ;; Fonts
  ;; ================================================================
  
  ;; |あああああ|
  ;; |+-+-+-+-+-|
  ;; |imimimimim|
  
  ;; (when (x-list-fonts "Ricty")
  ;;   (let* ((size 14)
  ;;          (asciifont "Ricty")
  ;;          (jpfont "Ricty")
  ;;          (h (* size 10))
  ;;          (fontspec)
  ;;          (jp-fontspec))
  ;;     (set-face-attribute 'default nil :family asciifont :height h)
  ;;     (setq fontspec (font-spec :family asciifont))
  ;;     (setq jp-fontspec (font-spec :family jpfont))
  ;;     (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
  ;;     (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
  ;;     (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
  ;;     (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  ;;     (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  ;;     (set-fontset-font nil '(#x0370 . #x03FF) fontspec)))
  
  (setq YaTeX-dvi2-command-ext-alist
        '(("Preview\\|TeXShop\\|TeXworks\\|Skim\\|mupdf\\|xpdf\\|Firefox\\|Adobe" . ".pdf")))
  (setq tex-command "/usr/texbin/ptex2pdf -l -ot '-synctex=1'")
  ;(setq tex-command "/usr/texbin/ptex2pdf -l -u -ot '-synctex=1'")
  ;(setq tex-command "/usr/local/bin/pdfplatex")
  ;(setq tex-command "/usr/local/bin/pdfplatex2")
  ;(setq tex-command "/usr/local/bin/pdfuplatex")
  ;(setq tex-command "/usr/local/bin/pdfuplatex2")
  ;(setq tex-command "/usr/texbin/pdflatex -synctex=1")
  ;(setq tex-command "/usr/texbin/lualatex -synctex=1")
  ;(setq tex-command "/usr/texbin/luajitlatex -synctex=1")
  ;(setq tex-command "/usr/texbin/xelatex -synctex=1")
  ;(setq tex-command "/usr/texbin/latexmk")
  ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
  ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -g > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
  ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
  ;(setq tex-command "/usr/texbin/latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
  ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -e '$bibtex=q/bibtex %O %B/' -e '$makeindex=q/makeindex %O -o %D %S/' -norc -gg -pdf")
  ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/lualatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
  ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/luajitlatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
  ;(setq tex-command "/usr/texbin/latexmk -e '$pdflatex=q/xelatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -xelatex")
  (setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "/usr/texbin/upbibtex")
                             ((string-match "platex" tex-command) "/usr/texbin/pbibtex")
                             ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/usr/texbin/bibtexu")
                             ((string-match "pdflatex\\|latex" tex-command) "/usr/texbin/bibtex")
                             (t "/usr/texbin/pbibtex")))
  (setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "/usr/texbin/mendex")
                                ((string-match "platex" tex-command) "/usr/texbin/mendex")
                                ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "/usr/texbin/texindy")
                                ((string-match "pdflatex\\|latex" tex-command) "/usr/texbin/makeindex")
                                (t "/usr/texbin/mendex")))
  ;(setq dvi2-command "/usr/bin/open -a Preview")
  (setq dvi2-command "/usr/bin/open -a Skim")
  ;(setq dvi2-command "/usr/bin/open -a TeXShop")
  ;(setq dvi2-command "/usr/bin/open -a TeXworks")
  ;(setq dvi2-command "/usr/bin/open -a Firefox")
  (setq dviprint-command-format "/usr/bin/open -a \"Adobe Reader\" `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")
  
  (defun skim-forward-search ()
    (interactive)
    (progn
      (process-kill-without-query
       (start-process
        "displayline"
        nil
        "/Applications/Skim.app/Contents/SharedSupport/displayline"
        (number-to-string (save-restriction
                            (widen)
                            (count-lines (point-min) (point))))
        (expand-file-name
         (concat (file-name-sans-extension (or YaTeX-parent-file
                                               (save-excursion
                                                 (YaTeX-visit-main t)
                                                 buffer-file-name)))
                 ".pdf"))
        buffer-file-name))))
)

(when (or (eq system-type 'windows-nt)
          (eq system-type 'cygwin))
  (setq file-name-coding-system 'cp932)
  
  ;; Ctrl-gとかでベルを鳴らさないようにします。
  (setq visible-bell t)
  (setq ring-bell-function 'ignore)
  
  ;;;** 標準IMEの設定
  (setq default-input-method "W32-IME")
  
  ;;;** IMEの初期化
  (w32-ime-initialize)
  
  ;;;** IME状態のモードライン表示
  (setq-default w32-ime-mode-line-state-indicator "[--]")
  (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
  
  ;;;** IME OFF時の初期カーソルカラー
  (set-cursor-color "red")
  
  ;;;** IME ON/OFF時のカーソルカラー
  (add-hook 'input-method-activate-hook
            (lambda() (set-cursor-color "green")))
  (add-hook 'input-method-inactivate-hook
            (lambda() (set-cursor-color "red")))
  
  ;;;** バッファ切り替え時にIME状態を引き継ぐ
  (setq w32-ime-buffer-switch-p nil)
  
  ;;;** Ctrl-Oでトグルするようにする
  (global-set-key (kbd "C-o") 'toggle-input-method)
  
  ;; ;; cp932エンコード時の表示を「P」とする
  ;; (coding-system-put 'cp932 :mnemonic ?P)
  ;; (coding-system-put 'cp932-dos :mnemonic ?P)
  ;; (coding-system-put 'cp932-unix :mnemonic ?P)
  ;; (coding-system-put 'cp932-mac :mnemonic ?P)
)

(message "%s" "%% init.elは完了しました %%")

;;; init.el ends here
