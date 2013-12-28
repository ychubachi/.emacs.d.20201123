
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom.el"))
    (load (expand-file-name custom-file) t nil nil))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

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

(require 'cl)

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(smartrep graphviz-dot-mode))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; markdownモードでアウトラインを有効にする
;; ================================================================
(add-hook 'markdown-mode-hook
          '(lambda () (outline-minor-mode t)))

;; ================================================================
;; 連続操作を素敵にするsmartrep.el作った - sheephead
;; http://sheephead.homelinux.org/2011/12/19/6930/
;; ================================================================

(require 'smartrep)
(eval-after-load "org"
  '(progn
     (smartrep-define-key
      org-mode-map "C-c" '(("C-n" . (lambda ()
                                      (outline-next-visible-heading 1)))
                           ("C-p" . (lambda ()
                                      (outline-previous-visible-heading 1)))))))

;; ================================================================
;; graphviz-dot-mode
;; ================================================================
(add-to-list 'auto-mode-alist '("\\.dot$" . graphviz-dot-mode))

(require 'ox-md)

(require 'ox-mediawiki)

(require 'ox-latex)

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-latex-default-class "jsarticle")

(setq org-export-in-background nil)

(cond ((eq system-type 'gnu/linux)
       (setq org-latex-pdf-process '("latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
       (setq org-file-apps '(("pdf" . "evince %s"))))
      ((eq system-type 'darwin)
       (setq org-latex-pdf-process '("latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
       (setq org-file-apps '(("pdf" . "/usr/bin/open -a Skim %s")))))

;; jsarticle
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

(dolist (package '(mediawiki))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'mediawiki)

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(region-bindings-mode key-chord))
  (when (not (package-installed-p package))
    (package-install package)))

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
  (find-file "~/.emacs.d/org/setup.org"))

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
