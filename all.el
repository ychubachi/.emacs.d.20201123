;; init.el --- Emacsの初期設定

;;; サーバを開始します
(load "server")
(unless (server-running-p)		; サーバが起動していないならば
  (server-start))			; サーバを開始する

;;; カスタマイズ設定
(setq custom-file "~/.emacs.d/custom.el")

(if (file-exists-p custom-file)
    (load custom-file))

;;; packageシステムを初期化します
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(package-refresh-contents)

;;; use-packageを導入します
;; - bind-key も利用できるようになります
(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)

;;; C-h を DELにします
(define-key key-translation-map [?\C-h] [?\C-?])

;;; C-c ? を help-for-help にします
(bind-key "C-c ?" 'help-for-help)

;;; 日本語/UTF-8にする
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;;; describe-personal-keybindings をバインドします
(bind-key "C-c d" 'describe-personal-keybindings)

;;; Ctrl-OでIMEをトグルするようにする

;; 注意: in ~/.Xresourcesに
;;   Emacs*useXIM:	false
;; と設定しておくこと。設定したら
;;   xrdb ~/.Xresources
;; を端末で実行する。
;;
;; 筆者の場合，OS側でもC-oでIMEを切り替えるようにしているため，
;; これを設定しておかないと，C-c C-oなどが効かなくなる．

(global-set-key (kbd "C-o") 'toggle-input-method)

;;; mozc-popup の設定

;; - http://www11.atwiki.jp/s-irie/pages/21.html#basic
;; - http://d.hatena.ne.jp/iRiE/20100530/1275212234

(use-package mozc-popup
  :if (eq system-type 'gnu/linux)
  :init
  (progn
    (setq default-input-method "japanese-mozc")
    (setq mozc-candidate-style 'popup))
  :ensure t)

;;;  日本語入力時のカーソル色の変更

(add-hook 'input-method-activate-hook
	  '(lambda () (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
	  '(lambda () (set-cursor-color "orchid")))

;;; outline-minor-modeのプリフィックスがC-c @なので、C-c C-oにする
;; http://emacswiki.org/emacs/OutlineMinorMode
(add-hook 'outline-minor-mode-hook
          (lambda () (bind-key "C-c C-o"
			       outline-mode-prefix-map)))

;;; outline-minor-modeを有効にするモードを設定
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

;;; デフォルトフォントの設定
(when (eq system-type 'gnu/linux)
      (add-to-list 'default-frame-alist '(font . "ricty-13.5")))

;;; wdired でリネームできるようにします
(use-package wdired
  :init
  (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map))

;;; exec-path-from-shell
(use-package exec-path-from-shell
  :init
  (progn (exec-path-from-shell-initialize))
  :ensure t)

;;; shell-pop
(use-package shell-pop
  :init
  (custom-set-variables
   '(shell-pop-autocd-to-working-dir nil)
   '(shell-pop-shell-type
     (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
   '(shell-pop-universal-key "C-z")
   '(shell-pop-window-height 30))
  :ensure t)

;;; undo-tree
(use-package undo-tree
  :init
  (global-undo-tree-mode t)
  :ensure t)

;;; yasnippet
(use-package yasnippet
  :init
  (yas-global-mode 1)
  :ensure t)

;;; magit
(use-package magit
  :bind ("C-c g" . magit-status)
  :ensure t)

;;; open-junk-file
(use-package open-junk-file
  :bind ("C-c j" . open-junk-file)
  :init
  (setq open-junk-file-directory "~/tmp/junk/%Y/%m/%d-%H%M%S.")
  :ensure t)

;;; paredit
(use-package paredit
  :init
  (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
  (add-hook 'lisp-mode-hook 'enable-paredit-mode)
  (add-hook 'ielm-mode-hook 'enable-paredit-mode)
  :ensure t)

;;; lispxmp
(use-package lispxmp
  :init
  (bind-key "C-c e" 'lispxmp emacs-lisp-mode-map)
  :ensure t)

;;; multiple-cursors
(use-package multiple-cursors
  :ensure t)

;;; smartrep
(use-package smartrep
  :ensure t)

;;; region-bindings-mode
(use-package region-bindings-mode
  :init
  (progn
    (region-bindings-mode-enable)
    (bind-keys :map region-bindings-mode-map
	       ("a" . mc/mark-all-like-this)
	       ("p" . mc/mark-previous-like-this)
	       ("n" . mc/mark-next-like-this)
	       ("m" . mc/mark-more-like-this-extended)
	       ("e" . mc/edit-lines)))
  :ensure t)

;;; migemo
(use-package migemo
  :if (executable-find "cmigemo")
  :init
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init)
  (setq migemo-command "cmigemo")
  (cond
   ((eq system-type 'gnu/linux)
    (setq migemo-dictionary
	  "/usr/share/cmigemo/utf-8/migemo-dict"))
   ((eq system-type 'darwin)
    (setq migemo-dictionary
	  "/usr/local/share/migemo/utf-8/migemo-dict")))
  :ensure t)

;;; ace-jump-mode
(use-package ace-jump-mode
  :bind (("C-c ." . ace-jump-mode)
	 ("C-c ," . ace-jump-line-mode))
  :ensure t)

;;; org関連
(defun my/org-caputure-templates ()
  (setq org-capture-templates
        (quote
         (("t" "Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO %?
")
          ("l" "Link as Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO %?
Link: %a
Text: %i
")
          ("j" "Journal" entry (file+datetree "journal.org")
           "* %?
")
          ("b" "Bookmark" entry (file+headline "bookmark.org" "Bookmarks")
           "* %a :bookmark:
引用: %i
%?
")
          ))))

;;; 
(defun my/ox-latex ()
  (require 'ox-latex)
  (setq org-latex-default-class "bxjsarticle")
  (setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/xelatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/makeindex -o %D %S/' -norc -gg -pdf %f"))
  (setq org-export-in-background t)

  (add-to-list 'org-latex-classes
               '("bxjsarticle"
                 "\\documentclass{bxjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\usepackage{xltxtra}
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\ifdefined\\kanjiskip
\\usepackage{pxjahyper}
\\hypersetup{colorlinks=true}
\\else
\\ifdefined\\XeTeXversion
\\hypersetup{colorlinks=true}
\\else
\\ifdefined\\directlua
\\hypersetup{pdfencoding=auto,colorlinks=true}
\\else
\\hypersetup{unicode,colorlinks=true}
\\fi
\\fi
\\fi"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(defun my/ox-beamer ()
  (require 'ox-beamer)
  (add-to-list 'org-latex-classes
               '("beamer"
                 "\\documentclass[t]{beamer}
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\setbeamertemplate{navigation symbols}{}
\\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
\\AtBeginSection[]
{
  \\begin{frame}<beamer>{Outline}
  \\tableofcontents[currentsection,currentsubsection]
  \\end{frame}
}
\\setbeamertemplate{navigation symbols}{}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("beamer_lecture"
                 "\\documentclass[t]{beamer}
[NO-DEFAULT-PACKAGES]
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\setbeamertemplate{navigation symbols}{}
\\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
\\AtBeginPart
{
\\begin{frame}<beamer|handout>
\\date{\\insertpart}
\\maketitle
\\end{frame}
}
\\AtBeginSection[]
{
\\begin{frame}<beamer>
\\tableofcontents[currentsection,currentsubsection]
\\end{frame}
}"
                   ("\\part{%s}" . "\\part*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

(defun my/smartrep ()
  (smartrep-define-key
      org-mode-map
      "C-c" '(("C-n" . (lambda ()
                         (outline-next-visible-heading 1)))
              ("C-p" . (lambda ()
                         (outline-previous-visible-heading 1))))))

;;; 
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)
   ("C-c a" . org-agenda)
   ("C-c b" . org-switchb))
  :init
  (progn
    (my/org-caputure-templates)
    (setq org-todo-keywords
	  (quote
	   ((sequence
	     "TODO(t)"
	     "WIP(p)"
	     "WAIT(w)"
	     "|"
	     "DONE(d)"
	     "SOMEDAY(s)"
	     "CANCEL(c)"))))
    (setq org-babel-load-languages
	  (quote
	   ((emacs-lisp . t)
	    (dot . t)
	    (java . t)
	    (ruby . t)
	    (sh . t))))
    (setq org-babel-sh-command "bash")
    (setq org-deadline-warning-days 7)
    (setq org-agenda-custom-commands
	  (quote
	   (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
	    ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
	    ("p" "私用" tags-todo "+私用" nil)
	    ("P" "私用以外" tags-todo "-私用" nil)
	    ("n" "Agenda and all TODO's" ((agenda "" nil)
					  (alltodo "" nil)) nil))))
    (setq org-confirm-babel-evaluate nil)
    (setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
    (setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")
    (custom-set-faces
     '(org-column-title
       ((t (:background "grey30" :underline t :weight bold :height 135)))))
    (custom-set-variables
     '(org-export-in-background nil)
     '(org-src-fontify-natively t))
    (require 'ox-md) 
    (my/ox-latex)
    (my/ox-beamer)
    (add-to-list 'org-latex-packages-alist '("" "minted"))
    (setq org-latex-listings 'minted)
    (use-package ox-reveal :ensure t)
    (require 'org-protocol))
  :config
  (progn
    (bind-key "M-q" 'toggle-truncate-lines org-mode-map)
    (my/smartrep))
  :ensure t)

(use-package helm-config
  :bind (("M-x" . helm-M-x)
	 ("C-c h" . helm-mini)
	 ("C-x C-r" . helm-recentf))
  :init
  (progn
    (use-package helm-descbinds
      :init
      (helm-descbinds-mode)
      :ensure t)
    (use-package helm-migemo
      :if (executable-find "cmigemo")
      :init
      (progn
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
	    ad-do-it)))
      :ensure t)
    (use-package helm-package :ensure t))
  :ensure helm)

;;; 未整理
;;; Clean Mode Line
;; - mode-lineのモード情報をコンパクトに表示する- Life is very short
;;   - http://d.hatena.ne.jp/syohex/20130131/1359646452

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


;;; フォントサイズをPU，PDで変更できるようにする

;; - Page Up，Page Downで操作
;; - Macの場合はfn+↑，fn+↓

(global-set-key (kbd "<prior>") 'text-scale-increase)
(global-set-key (kbd "<next>")  'text-scale-decrease)

;;; eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

;;; TODO 不要な行末の空白を削除

;; - org-modeで保存すると、勝手にフォーマットが変わるのが変

;; - 保存する前に，不要な空白を取り除きます．
;; - 参考
;;   - [[http://batsov.com/articles/2011/11/25/emacs-tip-number-3-whitespace-cleanup/][Emacs Tip #3: Whitespace Cleanup - (think)]]
;;   - [[http://qiita.com/itiut@github/items/4d74da2412a29ef59c3a][Emacs - whitespace-modeを使って、ファイルの保存時に行末のスペースや末尾の改行を削除する - Qiita]]

;; (add-hook 'before-save-hook
;; 	  'whitespace-cleanup)

;;; AUCTeX

(use-package tex-jp
  :init
  (progn
    (setq preview-image-type 'dvipng)
    (setq TeX-source-correlate-method 'synctex)
    (setq TeX-source-correlate-start-server t)
    (add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
    (add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
    (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
    (add-hook 'LaTeX-mode-hook
	      (function (lambda ()
			  (add-to-list 'TeX-command-list
				       '("Latexmk"
					 "latexmk %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-pdfupLaTeX"
					 "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/mendex %%O -U -o %%D %%S/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-pdfupLaTeX2"
					 "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/mendex %%O -U -o %%D %%S/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX2"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-pdfLaTeX"
					 "latexmk -e '$pdflatex=q/pdflatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-LuaLaTeX"
					 "latexmk -e '$pdflatex=q/lualatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-LuaJITLaTeX"
					 "latexmk -e '$pdflatex=q/luajitlatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
			  (add-to-list 'TeX-command-list
				       '("Latexmk-XeLaTeX"
					 "latexmk -e '$pdflatex=q/xelatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
					 TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
			  (add-to-list 'TeX-command-list
				       '("xdg-open"
					 "xdg-open %s.pdf"
					 TeX-run-discard-or-function t t :help "Run xdg-open"))
			  (add-to-list 'TeX-command-list
				       '("Evince"
					 "evince %s.pdf"
					 TeX-run-discard-or-function t t :help "Run Evince"))
			  (add-to-list 'TeX-command-list
				       '("fwdevince"
					 "fwdevince %s.pdf %n \"%b\""
					 TeX-run-discard-or-function t t :help "Forward search with Evince"))
			  (add-to-list 'TeX-command-list
				       '("Okular"
					 "okular --unique \"file:\"%s.pdf\"#src:%n %a\""
					 TeX-run-discard-or-function t t :help "Forward search with Okular"))
			  (add-to-list 'TeX-command-list
				       '("zathura"
					 "zathura -s -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf"
					 TeX-run-discard-or-function t t :help "Run zathura"))
			  (add-to-list 'TeX-command-list
				       '("fwdzathura"
					 "zathura --synctex-forward %n:0:%b %s.pdf"
					 TeX-run-discard-or-function t t :help "Forward search with zathura"))
			  (add-to-list 'TeX-command-list
				       '("qpdfview"
					 "qpdfview --unique \"\"%s.pdf\"#src:%b:%n:0\""
					 TeX-run-discard-or-function t t :help "Forward search with qpdfview"))
			  (add-to-list 'TeX-command-list
				       '("TeXworks"
					 "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texworks --position=%%{page+1} %%{output}\""
					 TeX-run-discard-or-function t t :help "Run TeXworks"))
			  (add-to-list 'TeX-command-list
				       '("TeXstudio"
					 "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texstudio --pdf-viewer-only --page %%{page+1} %%{output}\""
					 TeX-run-discard-or-function t t :help "Run TeXstudio"))
			  (add-to-list 'TeX-command-list
				       '("MuPDF"
					 "mupdf %s.pdf"
					 TeX-run-discard-or-function t t :help "Run MuPDF"))
			  (add-to-list 'TeX-command-list
				       '("Firefox"
					 "firefox -new-window %s.pdf"
					 TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
			  (add-to-list 'TeX-command-list
				       '("Chromium"
					 "chromium --new-window %s.pdf"
					 TeX-run-discard-or-function t t :help "Run Chromium")))))

    ;;
    ;; RefTeX with AUCTeX
    ;;
    (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
    (setq reftex-plug-into-AUCTeX t)

    ;;
    ;; kinsoku.el
    ;;
    (setq kinsoku-limit 10))
  :config
  (progn
    (setq TeX-engine-alist '((pdfuptex "pdfupTeX"
				       "ptex2pdf -u -e -ot '%S %(mode)'"
				       "ptex2pdf -u -l -ot '%S %(mode)'"
				       "euptex")))
    (setq japanese-TeX-engine-default 'pdfuptex)
    (setq TeX-view-program-selection '((output-dvi "Evince")
				       (output-pdf "Evince")))
    (setq japanese-LaTeX-default-style "jsarticle")
    (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
      (delq (assoc command TeX-command-list) TeX-command-list)))
  :ensure auctex)

;;; init.el ends here
