;; init.el --- Emacsの初期設定

;;; 説明

;;;; Mac用Emacsについて
;; - Emacs Mac Portを仕様

;; Macで本家EmacsとHomebrew IMEパッチ版とEmacs Mac PortとAquamacsを比べてみる。 | たったのセブンクレジット
;;   (browse-url "http://www.sevencredit.com/2014/07/02/580/")

;; Downloads · railwaycat/emacs-mac-port Wiki
;;   (browse-url "https://github.com/railwaycat/emacs-mac-port/wiki/Downloads")

;; Macで本家EmacsとHomebrew IMEパッチ版とEmacs Mac PortとAquamacsを比べてみる。 | たったのセブンクレジット
;;   (browse-url "http://www.sevencredit.com/2014/07/02/580/")

;;; 基本設定
;;;; サーバを開始します

;; - Emacs serverの開始
;; - Emacs 既に起動している場合は立ち上げない
;;   - [[http://stackoverflow.com/questions/5570451/how-to-start-emacs-server-only-if-it-is-not-started][configuration - How to start emacs server only if it is not started? - Stack Overflow]]

(load "server")
(unless (server-running-p)		; サーバが起動していないならば
  (server-start))			; サーバを開始する

;;;; packageシステムを初期化します
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(package-refresh-contents)

;;;; use-packageを導入します

;; use-packageマクロを利用できるようにします。
;;  - [[https://github.com/jwiegley/use-package][jwiegley/use-package]]
;;  - [[https://github.com/emacsattic/bind-key][emacsattic/bind-key]]
;;     - you can use M-x describe-personal-keybindings to see all such bindings you've set throughout your Emacs.
;;   (describe-personal-keybindings)
;; - bind-key も利用できるようになります

(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)

;;;; C-h を DELにします

;; - C-h が押されたら，C-? (<DEL>) に変換する．
;; - ヘルプは[F1]でも参照できる．
;; - 参考
;; 	 - [[http://akisute3.hatenablog.com/entry/20120318/1332059326][EmacsのC-hをbackspaceとして使用する - 勉強日記]]
;; 	 - [[http://www.gnu.org/software/emacs/manual/html_node/efaq/Swapping-keys.html#Swapping-keys][Swapping keys - GNU Emacs FAQ]]
;; - keyboad-translate関数はサーバにする際動作しなかった
;; 	 - [[http://lists.gnu.org/archive/html/help-gnu-emacs/2009-10/msg00505.html][Re: keyboard-translate not working with emacs daemon]]

(define-key key-translation-map [?\C-h] [?\C-?])

;;;; C-c ? を help-for-help にします
(bind-key "C-c ?" 'help-for-help)

;;; 日本語/UTF-8にします

;; - 言語環境を日本語に，コード体系をUTF-8にします．

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;;; describe-personal-keybindings をバインドします
(bind-key "C-c d" 'describe-personal-keybindings)

;;; Linux用IMEの設定
(when (eq system-type 'gnu/linux)
  ;; Ctrl-OでIMEをトグルするようにする
  ;;
  ;;  注意: ~/.Xresourcesに
  ;;    Emacs*useXIM:	false
  ;;  と設定しておくこと。設定したら
  ;;    xrdb ~/.Xresources
  ;;  を端末で実行する。
  ;;
  ;;  筆者の場合、OS側でもC-oでIMEを切り替えるようにしているため，
  ;;  これを設定しておかないと，C-c C-oなどが効かなくなる．
  ;;
  (global-set-key (kbd "C-o") 'toggle-input-method)
  ;; 日本語入力時のカーソル色の変更
  (add-hook 'input-method-activate-hook
	    '(lambda () (set-cursor-color "green")))
  (add-hook 'input-method-inactivate-hook
	    '(lambda () (set-cursor-color "orchid"))))

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

;;; outline-minor-modeのキーバインディング

;; Emacs Lispの汎変数（とその他） - Qiita - http://qiita.com/kawabata@github/items/9a1a1e211c57a56578d8

(use-package outline
  :config
  (progn
    ;; C-c @ になっているプリフィックスを C-c C-o にします
    (setq outline-minor-mode-prefix "\C-c\C-o")
    ;; org-mode 風のキーバインディングを設定します
    (bind-key "<tab>" 'org-cycle
	      outline-minor-mode-map)
    (bind-key "<backtab>" 'org-global-cycle ; S-<tab> ?
 	      outline-minor-mode-map)
    (bind-key "C-c C-f" 'outline-forward-same-level
	      outline-minor-mode-map)
    (bind-key "C-c C-b" 'outline-backward-same-level
	      outline-minor-mode-map)
    (bind-key "C-c C-n" 'outline-next-visible-heading
	      outline-minor-mode-map)
    (bind-key "C-c C-p" 'outline-previous-visible-heading
	      outline-minor-mode-map)))

;;; outline-minor-modeを有効にするモードを設定
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

;;; デフォルトフォントの設定

;; ↓のテーブルが揃っていればOK
;;  |あぱ　ああ|
;;  |+-+-+-+-+-|
;;  |imimimimim|

;; ｰ Fontに関する調査
;;   - [[file:test.org::*Emacs%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%81%8A%E8%A9%B1][Emacsのフォントのお話]]
;;   - この値はcustomize可能です．

(cond
 ((eq system-type 'gnu/linux)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
 ((eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(font . "ricty-14"))))

;;; wdired でリネームできるようにします

;; diredモードで r キーを押すと編集モードに入る．
;; 完了したらC-c C-cで決定．C-c ESCでキャンセル．

;; wdiredのrequireはdired-mode-mapを定義するために必要． -> ??

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
(use-package multiple-cursors :ensure t)

;;; smartrep
(use-package smartrep :ensure t)

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

;;; org-directory
(setq org-agenda-files (quote ("~/Dropbox/Org/")))
(setq org-default-notes-file "~/Dropbox/Org/notes.org")
(setq org-directory "~/Dropbox/Org")

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

;;; my/ox-latex
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
;;; my/ox-beamer
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

;;; org-mode 用 smartrep
(defun my/smartrep ()
  (smartrep-define-key
      org-mode-map
      "C-c" '(("C-n" . (lambda ()
                         (outline-next-visible-heading 1)))
              ("C-p" . (lambda ()
                         (outline-previous-visible-heading 1))))))

;;; org-mode 本体
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

;;; helm の設定
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

;;; - Page Up，Page Downで操作
;;; - Macの場合はfn+↑，fn+↓
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

;; #+BABEL: :cache yes :tangle yes :noweb yes

;; * これはなに？
;; ** 使い方
;;   - C-c C-v t でinit.elを生成
;; 	- [[http://orgmode.org/manual/Header-arguments-in-Org-mode-properties.html#Header-arguments-in-Org-mode-properties][Header arguments in Org mode properties - The Org Manual]]
;;   - [[http://cask.readthedocs.org/en/latest/index.html][Cask — Cask 0.7.0]]
;;   - 日本のEmacsユーザ向け．
;;   - Emacsを設定するためのelです．
;; 	- [[https://github.com/ychubachi/.emacs.d/blob/master/init.org][.emacs.d/init.org at master · ychubachi/.emacs.d]]
;;   - preludeを意識しています
;; 	- [[http://batsov.com/prelude/][Prelude by bbatsov]]
;;   - コードネーム候補
;; 	- aperitif 食前酒
;;   - daemonについて
;;   - 対応するEmacsのバージョンは24.3（2013-03-11公開版）以降です．
;; 	- [[http://www.gnu.org/software/emacs/][GNU Emacs - GNU Project - Free Software Foundation (FSF)]]
;; 	- [[http://www.gnu.org/software/emacs/news/NEWS.24.3]]
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/elisp/Lexical-Binding.html][Lexical Binding - GNU Emacs Lisp Reference Manual]]
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/elisp/Closures.html#Closures][Closures - GNU Emacs Lisp Reference Manual]]

;;   - init.elについて
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/emacs/Init-File.html#Init-File][Init File - GNU Emacs Manual]]
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/emacs/Init-Syntax.html#Init-Syntax][Init Syntax - GNU Emacs Manual]]
;; 	  - init fileの文法．
;; 	  - 特定の変数は自動的にbuffer localになる．
;; 	- この場合はset-defaultを使うこと．

;; ** カスタマイズ
;;   - custom.elを最後に読むので，ここでの設定を上書きできます．
;;   - custom.elはgitではignoreします．
;;   - Dropboxと連携したorg-modeとMobileOrgのための設定
;;   - [[http://d.hatena.ne.jp/a_bicky/20131230/1388396559][custom-set-variables は使わない方が良いかもしれない - あらびき日記]]
;; ** 準備
;; *** git submodule
;;   - git submodule init
;;   - git submodule update
;; *** フォント
;;   - Ricty のインストール
;; *** aspell コマンドのインストール
;;   - git-commit-mode-hook でflyspellが自動的にonになる．
;;   - .aspell.conf の設定
;; 	- [[http://sky-y.hatenablog.jp/entry/20091229/1262106336][YaTeX + aspell - 雲行きそらゆきココロイキ]]

;;   Error enabling Flyspell mode:
;;   (Error: No word lists can be found for the language "ja_JP".)

;; * パッケージ
;; ** パッケージの設定
;; #+NAME: package
;; #+begin_src emacs-lisp
;;   <<exec-path-from-shell>>
;;   <<shell-pop>>
;;   <<undo-tree>>
;;   <<yasnippet>>
;;   <<magit>>
;;   <<open-junk-file>>
;;   <<paredit>>
;;   <<lispxmp>>
;;   <<multiple-cursors>>
;;   <<smartrep>>
;;   <<region-bindings-mode>>
;;   <<migemo>>
;;   <<org>>
;;   <<helm>>
;; #+end_src

;; ** ShellのPATH設定を引き継ぐ
;;   - [[http://qiita.com/catatsuy/items/3dda714f4c60c435bb25][EmacsでPATHの設定が引き継がれない問題をエレガントに解決する - Qiita {キータ}]]

;; #+NAME: exec-path-from-shell
;; #+begin_src emacs-lisp
;;   (use-package exec-path-from-shell
;;                :config
;;                (progn (exec-path-from-shell-initialize))
;;                :ensure t)
;; #+end_src

;; ** shell-pop

;; #+NAME: shell-pop
;; #+begin_src emacs-lisp
;;   (use-package shell-pop
;;                :config
;;                (custom-set-variables
;;                 '(shell-pop-autocd-to-working-dir nil)
;;                 '(shell-pop-shell-type
;;                   (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
;;                 '(shell-pop-universal-key "C-z")
;;                 '(shell-pop-window-height 30))
;;                :ensure t)
;; #+end_src

;; ** Undo Tree
;; #+NAME: undo-tree
;; #+begin_src emacs-lisp
;;   (use-package undo-tree
;;                :config
;;                (global-undo-tree-mode t)
;;                :ensure t)
;; #+end_src

;; ** yasnippet
;;   - [[https://github.com/capitaomorte/yasnippet][capitaomorte/yasnippet]]
;;   - [[http://fukuyama.co/yasnippet][yasnippet 8.0の導入からスニペットの書き方、anything/helm/auto-completeとの連携 - Web学び]]

;; #+NAME: yasnippet
;; #+begin_src emacs-lisp
;;   (use-package yasnippet
;;                :config
;;                (yas-global-mode 1)
;;                :ensure t)
;; #+end_src
;; ** Magit
;; #+NAME: magit
;; #+begin_src emacs-lisp
;;   (use-package magit
;;                :bind ("C-c g" . magit-status)
;;                :ensure t)
;; #+end_src

;; ** open-junk-file

;; #+NAME: open-junk-file
;; #+begin_src emacs-lisp
;;   (use-package open-junk-file
;;                :bind ("C-c j" . open-junk-file)
;;                :config
;;                (setq open-junk-file-directory "~/tmp/junk/%Y/%m/%d-%H%M%S.")
;;                :ensure t)
;; #+end_src

;; ** paredit - カッコの対応を保持して編集

;; #+NAME: paredit
;; #+begin_src emacs-lisp
;;   (use-package paredit
;;                :init
;;                (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
;;                (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
;;                (add-hook 'lisp-mode-hook 'enable-paredit-mode)
;;                (add-hook 'ielm-mode-hook 'enable-paredit-mode)
;;                :ensure t)
;; #+end_src

;; ** lispxmp - lisp式の評価結果を注釈する

;;   - M-; M-; で lispxmp用コメントの自動挿入
;;   - C-c e で評価結果を注釈

;; #+NAME: lispxmp
;; #+begin_src emacs-lisp
;;   (use-package lispxmp
;;                :init
;;                (bind-key "C-c e" 'lispxmp emacs-lisp-mode-map)
;;                :ensure t)
;; #+end_src

;; ** 複数のカーソルを扱う:multiple-cursors
;; - [[https://github.com/magnars/multiple-cursors.el][magnars/multiple-cursors.el]]

;; #+NAME: multiple-cursors
;; #+begin_src emacs-lisp
;;   (use-package multiple-cursors
;;                :ensure t)
;; #+end_src

;; ** リージョンがある間のキーバインディングを変更する

;; #+NAME: region-bindings-mode
;; #+begin_src emacs-lisp
;;   (use-package region-bindings-mode
;;                :init
;;                (progn
;;                  (region-bindings-mode-enable)
;;                  (bind-keys :map region-bindings-mode-map
;;                          ("a" . mc/mark-all-like-this)
;;                          ("p" . mc/mark-previous-like-this)
;;                          ("n" . mc/mark-next-like-this)
;;                          ("m" . mc/mark-more-like-this-extended)
;;                          ("e" . mc/edit-lines)))
;;                :ensure t)
;; #+end_src

;; ** smartrep.el
;; - [[http://sheephead.homelinux.org/2011/12/19/6930/][連続操作を素敵にするsmartrep.el作った - sheephead]]

;; #+NAME: smartrep
;; #+begin_src emacs-lisp
;;   (use-package smartrep
;;                :ensure t)
;; #+end_src

;; ** migemo
;; ローマ字で日本語をインクリメンタルサーチ

;; - 注意
;;   - cmigemoコマンドがインストールされていること．
;;   - locate migemo-dictで辞書の場所調べ，設定してください．
;; - 参考
;;   - https://github.com/emacs-jp/migemo
;;   - [[http://qiita.com/catatsuy/items/c5fa34ead92d496b8a51][migemoを使ってEmacsライフを快適に - Qiita {キータ}]]

;; #+NAME: migemo
;; #+begin_src emacs-lisp
;;   (use-package migemo
;;                :if (executable-find "cmigemo")
;;                :init
;;                (setq migemo-options '("-q" "--emacs"))
;;                (setq migemo-user-dictionary nil)
;;                (setq migemo-regex-dictionary nil)
;;                (setq migemo-coding-system 'utf-8-unix)
;;                (load-library "migemo")
;;                (migemo-init)
;;                (setq migemo-command "cmigemo")
;;                (cond
;;                 ((eq system-type 'gnu/linux)
;;                  (setq migemo-dictionary
;;                        "/usr/share/cmigemo/utf-8/migemo-dict"))
;;                 ((eq system-type 'darwin)
;;                  (setq migemo-dictionary
;;                        "/usr/local/share/migemo/utf-8/migemo-dict")))
;;                :ensure t)

;; #+end_src

;; ** org-mode
;; *** Orgについて
;; - マニュアル
;;   - [[http://orgmode.org/org.html][The Org Manual]]
;;   - [[http://orgmode.org/elpa.html][Org Emacs lisp Package Archive]]

;; - Dropboxとの連携
;;   - Dropboxと連携させると便利

;; - 準備
;;   - mkdir ~/Dropbox/Org
;; - org-directory のデフォルトは~/org
;; - これをDropboxの下にする．Dropbox/Org
;; - ディレクトリは自分で作ること．

;; - org-default-notes-file のデフォルトは .notes
;; - ただし，.notesを開いてもorgモードにならないので，エラーになる．
;; - だから，ファイル名は指定する必要がある． -> notes.org
;; - その他に，t: Todoとj: Journal（日記帳）を．

;; - notes.orgは，トップページ扱い
;; - org-agenda-files -> MobileOrgにPushする

;; | 説明                       | 変数名                 | 推奨               |
;; |----------------------------+------------------------+--------------------|
;; | 備忘録用ファイルを置く場所 | org-directory          | "~/Dropbox/Org"    |
;; | アジェンダファイルの指定   | org-agenda-files       | ("~/Dropbox/Org/") |
;; | デフォルトのノーツ         | org-default-notes-file | "notes.org"        |
;; | キャプチャ                 | org-capture-templates  | t: Todo j: Journal |


;; | 説明                           | 変数名                         | 推奨                          |
;; |--------------------------------+--------------------------------+-------------------------------|
;; | バックグランドでのエキスポート | org-export-in-background       | nil                           |
;; | 画像を表示                     | org-startup-with-inline-images | t                             |
;; | ToDoアイテムの状態             | org-todo-keywords              | TODO WAIT DONE SOMEDAY CANCEL |

;; | 変数名                  | 設定例                             |
;; |-------------------------+------------------------------------|
;; | op/repository-directory | "/home/yc/git/ychubachi.github.io" |
;; | op/site-domain          | "http://ychubachi.github.io/"      |

;; *** 全体の定義

;; #+NAME: org
;; #+begin_src emacs-lisp
;;   <<my/org-caputure-templates>>
;;   <<my/ox-latex>>
;;   <<my/ox-beamer>>
;;   <<my/smartrep>>
;;   (use-package org
;;                :bind
;;                <<org-bind>>
;;                :init
;;                (progn
;;                  (my/org-caputure-templates)
;;                  <<org-todo-keywords>>
;;                  <<org-babel-load-languages>>
;;                  <<org-babel-sh-command>>
;;                  <<org-deadline-warning-days>>
;;                  <<org-agenda-custom-commands>>
;;                  <<org-confirm-babel-evaluate>>
;;                  <<org/mobile>>
;;                  <<org-column-title>>
;;                  <<org/custom-set-variables>>
;;                  <<ox-md>> 
;;                  (my/ox-latex)
;;                  (my/ox-beamer)
;;                  <<minted>>
;;                  <<ox-reveal>>
;;                  <<ox-protocol>>)
;;                :config
;;                (progn
;;                  <<org/truncate-lines>>
;;                  (my/smartrep))
;;                :ensure t)
;; #+end_src

;; *** キーバインド
;; #+NAME: org-bind
;; #+begin_src emacs-lisp
;;   (("C-c l" . org-store-link)
;;    ("C-c c" . org-capture)
;;    ("C-c a" . org-agenda)
;;    ("C-c b" . org-switchb))
;; #+end_src

;; *** キャプチャ
;; #+NAME: my/org-caputure-templates
;; #+begin_src emacs-lisp
;;   (defun my/org-caputure-templates ()
;;     (setq org-capture-templates
;;           (quote
;;            (("t" "Todo" entry (file+headline "todo.org" "Tasks")
;;              "* TODO %?
;;   ")
;;             ("l" "Link as Todo" entry (file+headline "todo.org" "Tasks")
;;              "* TODO %?
;;   Link: %a
;;   Text: %i
;;   ")
;;             ("j" "Journal" entry (file+datetree "journal.org")
;;              "* %?
;;   ")
;;             ("b" "Bookmark" entry (file+headline "bookmark.org" "Bookmarks")
;;              "* %a :bookmark:
;;   引用: %i
;;   %?
;;   ")
;;             ))))
;; #+end_src

;; *** TODOの種類

;; #+NAME: org-todo-keywords
;; #+begin_src emacs-lisp
;;   (setq org-todo-keywords
;;         (quote
;;          ((sequence
;;            "TODO(t)"
;;            "WIP(p)"
;;            "WAIT(w)"
;;            "|"
;;            "DONE(d)"
;;            "SOMEDAY(s)"
;;            "CANCEL(c)"))))
;; #+end_src

;; *** 期日の何日前に予定表（Agenda）に表示するか

;; #+NAME: org-deadline-warning-days
;; #+begin_src emacs-lisp
;;   (setq org-deadline-warning-days 7)
;; #+end_src

;; *** 予定表生成追加命令

;; - [[http://orgmode.org/manual/Matching-tags-and-properties.html][Matching tags and properties - The Org Manual]]
;; - [[https://www.gnu.org/software/emacs/manual/html_node/org/Special-agenda-views.html][Special agenda views - The Org Manual]]

;; #+NAME: org-agenda-custom-commands
;; #+begin_src emacs-lisp
;;   (setq org-agenda-custom-commands
;; 	(quote
;; 	 (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
;; 	  ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
;; 	  ("p" "私用" tags-todo "+私用" nil)
;; 	  ("P" "私用以外" tags-todo "-私用" nil)
;; 	  ("n" "Agenda and all TODO's" ((agenda "" nil)
;; 					(alltodo "" nil)) nil))))
;; #+end_src

;; *** Babelで対応する言語
;; #+NAME: org-babel-load-languages
;; #+begin_src emacs-lisp
;;   (setq org-babel-load-languages
;;         (quote
;;          ((emacs-lisp . t)
;;           (dot . t)
;;           (java . t)
;;           (ruby . t)
;;           (sh . t))))
;; #+end_src
;; *** BabelのShellのコードの実行にbashを使う
;;    - デフォルトのシェルがzshなので，設定しておく．
;;    - 2014-01-24現在，customizationの対応ではない模様．

;; #+NAME: org-babel-sh-command
;; #+begin_src emacs-lisp
;; (setq org-babel-sh-command "bash")
;; #+end_src

;; *** org-confirm-babel-evaluate

;; #+NAME: org-confirm-babel-evaluate
;; #+begin_src emacs-lisp
;;   (setq org-confirm-babel-evaluate nil)
;; #+end_src

;; *** Linewrap

;; - [[http://superuser.com/questions/299886/linewrap-in-org-mode-of-emacs][Linewrap in Org-mode of Emacs? - Super User]]

;; #+NAME: org/truncate-lines
;; #+begin_src emacs-lisp
;;   (bind-key "M-q" 'toggle-truncate-lines org-mode-map)
;; #+end_src
;; *** Mobile Org関連

;; - [[https://github.com/matburt/mobileorg-android/wiki][Home · matburt/mobileorg-android Wiki]]


;; #+NAME: org/mobile
;; #+begin_src emacs-lisp
;;   (setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
;;   (setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")
;; #+end_src

;; *** カラムのタイトルのフォント
;; - Heightをフォントの高さに合わせる

;; #+NAME: org-column-title
;; #+begin_src emacs-lisp
;;   (custom-set-faces
;;    '(org-column-title
;; 	 ((t (:background "grey30" :underline t :weight bold :height 135)))))
;; #+end_src

;; *** カスタム変数

;; #+NAME: org/custom-set-variables
;; #+begin_src emacs-lisp
;; (custom-set-variables
;;  '(org-export-in-background nil)
;;  '(org-src-fontify-natively t))
;; #+end_src

;; *** Markdown export

;; #+NAME: ox-md
;; #+begin_src emacs-lisp
;;   (require 'ox-md)
;; #+end_src

;; *** LaTeX export

;; LaTeXでエキスポートできるようにします．
;; 下記URLのコードから，xelatex用の設定を抜き出しました．

;; − [[http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Emacs%2FOrg%20mode#h20d131a][Emacs/Org mode - TeX Wiki]] （2014-08-03 参照）

;; #+NAME: my/ox-latex
;; #+begin_src emacs-lisp
;;   (defun my/ox-latex ()
;;     (require 'ox-latex)
;;     (setq org-latex-default-class "bxjsarticle")
;;     (setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/xelatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/makeindex -o %D %S/' -norc -gg -pdf %f"))
;;     (setq org-export-in-background t)

;;     (add-to-list 'org-latex-classes
;;                  '("bxjsarticle"
;;                    "\\documentclass{bxjsarticle}
;;   [NO-DEFAULT-PACKAGES]
;;   \\usepackage{zxjatype}
;;   \\usepackage[ipa]{zxjafont}
;;   \\usepackage{xltxtra}
;;   \\usepackage{amsmath}
;;   \\usepackage{newtxtext,newtxmath}
;;   \\usepackage{graphicx}
;;   \\usepackage{hyperref}
;;   \\ifdefined\\kanjiskip
;;     \\usepackage{pxjahyper}
;;     \\hypersetup{colorlinks=true}
;;   \\else
;;     \\ifdefined\\XeTeXversion
;;       \\hypersetup{colorlinks=true}
;;     \\else
;;       \\ifdefined\\directlua
;;         \\hypersetup{pdfencoding=auto,colorlinks=true}
;;       \\else
;;         \\hypersetup{unicode,colorlinks=true}
;;       \\fi
;;     \\fi
;;   \\fi"
;;                      ("\\section{%s}" . "\\section*{%s}")
;;                      ("\\subsection{%s}" . "\\subsection*{%s}")
;;                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
;;                      ("\\paragraph{%s}" . "\\paragraph*{%s}")
;;                      ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
;; #+end_src

;; *** LeTeX (beamer) export
;;  パッケージの読み込み
;;  文書クラスの設定(beamer)

;; #+NAME: my/ox-beamer
;; #+begin_src emacs-lisp
;;   (defun my/ox-beamer ()
;;     (require 'ox-beamer)
;;     (add-to-list 'org-latex-classes
;;                  '("beamer"
;;                    "\\documentclass[t]{beamer}
;;   \\usepackage{zxjatype}
;;   \\usepackage[ipa]{zxjafont}
;;   \\setbeamertemplate{navigation symbols}{}
;;   \\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
;;   \\AtBeginSection[]
;;   {
;;     \\begin{frame}<beamer>{Outline}
;;     \\tableofcontents[currentsection,currentsubsection]
;;     \\end{frame}
;;   }
;;   \\setbeamertemplate{navigation symbols}{}"
;;                    ("\\section{%s}" . "\\section*{%s}")
;;                    ("\\subsection{%s}" . "\\subsection*{%s}")
;;                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
;;     (add-to-list 'org-latex-classes
;;                  '("beamer_lecture"
;;                    "\\documentclass[t]{beamer}
;;   [NO-DEFAULT-PACKAGES]
;;   \\usepackage{zxjatype}
;;   \\usepackage[ipa]{zxjafont}
;;   \\setbeamertemplate{navigation symbols}{}
;;   \\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
;;   \\AtBeginPart
;;   {
;;   \\begin{frame}<beamer|handout>
;;   \\date{\\insertpart}
;;   \\maketitle
;;   \\end{frame}
;;   }
;;   \\AtBeginSection[]
;;   {
;;   \\begin{frame}<beamer>
;;   \\tableofcontents[currentsection,currentsubsection]
;;   \\end{frame}
;;   }"
;;                      ("\\part{%s}" . "\\part*{%s}")
;;                      ("\\section{%s}" . "\\section*{%s}")
;;                      ("\\subsection{%s}" . "\\subsection*{%s}")
;;                      ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
;; #+end_src

;; *** LaTeXでソースコードのエクスポート

;; #+NAME: minted
;; #+begin_src emacs-lisp
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted)
;; #+end_src

;; *** org-reveal
;;   - https://github.com/yjwen/org-reveal

;; #+NAME: ox-reveal
;; #+begin_src emacs-lisp
;;   (use-package ox-reveal :ensure t)
;; #+end_src

;; *** org-protocol
;;   - [[http://orgmode.org/worg/org-contrib/org-protocol.html#sec-3-6][org-protocol.el – Intercept calls from emacsclient to trigger custom actions]]

;;   - C-c C-lでOrg形式のリンク挿入?
;;   - [[http://stackoverflow.com/questions/7464951/how-to-make-org-protocol-work][firefox - How to make org-protocol work? - Stack Overflow]]
;; 	- gistで公開してあげようかな
;;   - [[http://d.hatena.ne.jp/reppets/20111109/1320846292][Unityランチャーに自分でインストール/ビルドしたアプリケーションを登録する - reppets.log.1]]
;;   - [[http://kb.mozillazine.org/Register_protocol#Linux][Register protocol - MozillaZine Knowledge Base]]
;;   - [[http://orgmode.org/worg/org-contrib/org-protocol.html#sec-3-6]]
;; 	- 古い

;; #+begin_src
;; javascript:location.href='org-protocol://store-link://'+encodeURIComponent(location.href)
;; javascript:location.href='org-protocol://capture://t/'+encodeURIComponent(location.href)+'/'+encodeURIComponent(document.title)+'/'+encodeURIComponent(window.getSelection())
;; #+end_src

;; #+NAME: ox-protocol
;; #+begin_src emacs-lisp
;;   (require 'org-protocol)
;; #+end_src

;; *** my/smartrep
;; - eval-after-loadにより，orgがロードされた後，
;;   もしくは，既にロードされていれば即，実行する．
;; - TODO smartrepは既にrequireされている前提

;; #+NAME: my/smartrep
;; #+begin_src emacs-lisp
;;   (defun my/smartrep ()
;;     (smartrep-define-key
;;         org-mode-map
;;         "C-c" '(("C-n" . (lambda ()
;;                            (outline-next-visible-heading 1)))
;;                 ("C-p" . (lambda ()
;;                            (outline-previous-visible-heading 1))))))
;; #+end_src

;; ** Helm
;; *** Helmについて
;;    - [[http://d.hatena.ne.jp/a_bicky/20140104/1388822688][Helm をストレスなく使うための個人的な設定 - あらびき日記]]
;;    - [[https://github.com/emacs-helm/helm/wiki][Home · emacs-helm/helm Wiki]]
;;    - [[http://sleepboy-zzz.blogspot.jp/2012/09/anythinghelm.html][memo: AnythingからHelmに移行しました]]
;;    - [[http://www49.atwiki.jp/ntemacs/m/pages/32.html][NTEmacs @ ウィキ - helm を使うための設定 - @ｳｨｷﾓﾊﾞｲﾙ]]
;;    - [[http://qiita.com/akisute3@github/items/7c8ea3970e4cbb7baa97][Emacs - helm-mode 有効時でも helm-find-files は無効にする - Qiita {キータ}]]
;;    - [[http://www.fan.gr.jp/~ring/doc/elisp_19/elisp-jp_14.html#IDX592][GNU Emacs Lispリファレンス・マニュアル: 12. マクロ]]
;; 	 - 逆引用符は`,'の引数を評価し、 リスト構造にその値を入れます。
;;    - helm-mode 1 はおせっかいすぎるので使わない
;; *** 全体の定義

;; - helm-M-xを有効にする
;; - helm-miniを有効にする


;; #+NAME: helm
;; #+begin_src emacs-lisp
;;   (use-package helm-config
;;                :bind (("M-x" . helm-M-x)
;;                       ("C-c h" . helm-mini)
;;                       ("C-x C-r" . helm-recentf))
;;                :init
;;                (progn
;;                  <<helm-descbinds>>
;;                  <<helm-migemo>>
;;                  <<helm-package>>)
;;                :ensure helm)
;; #+end_src

;; *** helm-descbinds

;; - helm-descbinds-mode を評価すると、describe-bindings 関数が helm-descbinds 関数で上書きされる
;; - describe-bindings にはもともと C-h b がバインドされているので結果として C-h b で helm-descbinds が起動されるようになる
;; - TODO bind-keys を使ったほうが確認しやすいかもしれない

;; |                |                   | 上書き |
;; |----------------+-------------------+--------|
;; | helm-descbinds | describe-bindings | C-h b  | 

;; #+NAME: helm-descbinds
;; #+begin_src emacs-lisp
;;   (use-package helm-descbinds
;;                :init
;;                (helm-descbinds-mode)
;;                :ensure t)
;; #+end_src

;; *** helm-migemo - ローマ字検索

;; #+NAME: helm-migemo
;; #+begin_src emacs-lisp
;;   (use-package helm-migemo
;;                :if (executable-find "cmigemo")
;;                :init
;;                (progn
;;                  (setq helm-use-migemo t)

;;                  (defadvice helm-c-apropos
;;                    (around ad-helm-apropos activate)
;;                    "候補が表示されないときがあるので migemoらないように設定."
;;                    (let ((helm-use-migemo nil))
;;                      ad-do-it))

;;                  (defadvice helm-M-x
;;                    (around ad-helm-M-x activate)
;;                    "候補が表示されないときがあるので migemoらないように設定."
;;                    (let ((helm-use-migemo nil))
;;                      ad-do-it)))
;;                :ensure t)
;; #+end_src

;; *** package listをhelmで選択
;; - M-x helm-package で起動
;; - [[http://rubikitch.com/2014/11/16/helm-package/][emacs helm-package.el : パッケージをhelmインターフェースで即座に見付けてインストール | MELPA Emacs Lisp Elisp パッケージ インストール 設定 使い方 スクリーンショット | るびきち「日刊Emacs」]]

;; #+NAME: helm-package
;; #+begin_src emacs-lisp
;; (use-package helm-package :ensure t)
;; #+end_src

;; * カスタマイズ
;; カスタマイズ設定を保存するファイルの指定
;;   - 概要
;; 	 - カスタマイズ設定を保存するファイルを指定して，読み込みます．
;; 	   - custom.elには個人用の設定を書く
;; 	 - このコードで設定した値は，custom.el内で上書きすることができます．
;;   - 参考
;; 	 - [[http://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html][Saving Customizations - GNU Emacs Manual]]

;; #+NAME: custom-file
;; #+begin_src emacs-lisp
;;   (setq custom-file "~/.emacs.d/custom.el")
;;   (if (file-exists-p custom-file)
;; 	  (load custom-file))
;; #+end_src

;; #+PROPERTY: header-args:emacs-lisp :tangle wip.el
;; #+PROPERTY: header-args            :results silent

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
;;   ;; Ruby DSLs
;;   ;; ================================================================

;;   (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))

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
;;   ;; flymake関係
;;   ;; ================================================================

;;   (require 'flymake-ruby)
;;   (add-hook 'ruby-mode-hook 'flymake-ruby-load)

;;   (require 'flymake-haml)
;;   (add-hook 'haml-mode-hook 'flymake-haml-load)

;;   (require 'flymake-sass)
;;   (add-hook 'sass-mode-hook 'flymake-sass-load)

;;   (require 'flymake-coffee)
;;   (add-hook 'coffee-mode-hook 'flymake-coffee-load)

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

;; * Scala
;;   - 参考
;; 	- [[http://futurismo.biz/archives/2449][EmacsでScala開発環境を構築(Ensime) | Futurismo]]

;; #+begin_src emacs-lisp
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; (require 'sbt-mode)
;; #+end_src
;; * キーバインディング

;; ** 個人用キーマップの設定
;; #+begin_src emacs-lisp
;;   (defun my/fullscreen ()
;; 	(interactive)
;; 	(set-frame-parameter
;; 	 nil
;; 	 'fullscreen
;; 	 (if (frame-parameter nil 'fullscreen)
;; 	 nil
;; 	   'fullboth)))
;;   (global-set-key [f11] 'my/fullscreen)

;;   ;; (defun my/open-init-folder()
;;   ;;   "設定フォルダを開きます．"
;;   ;;   (interactive)
;;   ;;   (find-file "~/.emacs.d/init.org"))
;;   ;; (global-set-key (kbd "<f1>") 'my/open-init-folder)


;;   (defun my/other-window-backward ()
;; 	"Move to other window backward."
;; 	(interactive)
;; 	(other-window -1))
;; #+end_src

;; #+begin_src emacs-lisp
;;   (define-prefix-command 'personal-map)
;;   (global-set-key (kbd "C-.") 'personal-map)

;;   (define-key 'personal-map (kbd "C-n") 'other-window)
;;   (define-key 'personal-map (kbd "C-p") 'my/other-window-backward)

;;   (define-key 'personal-map (kbd "m") 'imenu)

;;   (define-key 'personal-map (kbd "i") 'yas-insert-snippet)
;;   (define-key 'personal-map (kbd "n") 'yas-new-snippet)
;;   (define-key 'personal-map (kbd "v") 'yas-visit-snippet-file)

;;   (define-key 'personal-map (kbd "y") 'helm-c-yas-complete)
;;   (define-key 'personal-map (kbd "s") 'helm-c-yas-create-snippet-on-region)

;;   (define-key 'personal-map (kbd "b") 'org-beamer-export-to-pdf)

;;   (cond ((eq system-type 'gnu/linux)
;; 	 (define-key 'personal-map (kbd "p") 'evince-forward-search))
;; 	((eq system-type 'darwin)
;; 	 (define-key 'personal-map (kbd "p") 'skim-forward-search)))
;; #+end_src

;; * TODO auto-complete - 自動補間
;;   - [[http://cx4a.org/software/auto-complete/index.ja.html][Auto Complete Mode - GNU Emacsのための最も賢い自動補完機能]]

;; * TODO Macでフォントを正しく設定する
;;    :PROPERTIES:
;;    :ID:       16b070ee-507e-49fa-b84d-fa573911ebeb
;;    :END:

;; - let* は，同じスコープ内のローカル変数への参照を許す(letは許さない）
;; - ifはthenを1つの式しか書けないのでcondを使う．whenもある．
;; - [[http://blog.sanojimaru.com/post/19807398882/cocoa-emacs-ricty][cocoa emacsでプログラミング用フォントRictyを使う]]
;;   ｰ この記事，あやしいかも．
;; - daemonで動かすとおちるかも

;; * TODO mu4e [[https://github.com/ychubachi/.emacs.d/blob/master/plugins-available/mu4e.org][(GitHub)]]
;; ** 概要
;; mu4eは，offlineimap及びmaildir-toolsと組み合わせることで動作する，
;; Gmail等IMAPサーバに対応する軽快なメールリーダである．

;; ** 外部ツール
;; *** OfflineImap
;; **** IMAP版のDropboxのようなもの
;; OfflineImapは，IMAPサーバにあるメールをローカルのファイルに
;; Maildir形式で同期するツールである．DropboxやOneDriveのIMAP版と考えれば
;; 分かりやすいかもしれない．

;; OfflineImapをバックグラウンドで定期的に実行することで，
;; 手元にあるローカルファイルが，IMAPサーバ上にあるメールと同期する．
;; OfflineImapは，新しいメールが届いていればダウンロードし，
;; ローカルでメールを削除したら，サーバのメールも削除する．

;; **** Gmailでの利用
;; ここでは，Gmailを利用することを前提に，
;; OfflineImapを設定する．

;; まず，Gmail側で設定を行う．
;; IMAPのフォルダ名を英語にするため，Gmailは「英語」の設定にする．
;; 実は，日本語のフォルダ名を，offlineimapのnametrans機能で
;; 日本語に変換することもできる．

;; しかしながら，
;; 筆者が試行錯誤したところ，このことに起因すると思われる
;; 文字コードに関連したエラーが発生してしまった．
;; 安定的な動作を期するため，Gmailの設定画面において、
;; 「使用する言語」を英語にしておくのが良さそうだ．

;; **** OfflineImapコマンドのインストール

;; #+begin_src sh
;;  sudo apt-get install offlineimap
;; #+end_src

;; - 設定例
;;   - [[https://github.com/spaetz/offlineimap/blob/master/offlineimap.conf][offlineimap/offlineimap.conf at master · spaetz/offlineimap]]

;; .netrcに，imapのログイン名とパスワードを書いておく．

;; 初回実行したら，97,388件のメールをダウンロードするのに508分55秒かかった．

;; **** バックグラウンドでの実行

;; offlineimapをバックグラウンドで動作させるにはいくつかの方法がある．
;; 手軽に始められる方法として以下のやり方がある．

;; #+begin_src sh
;;   (zsh)$  offlineimap &!
;;   (bash)$ nohup offlineimap &
;; #+end_src

;; **** 関連URL
;; - [[http://docs.offlineimap.org/en/latest/][Welcome to offlineimaps‘s documentation — OfflineImap 6.5.4 documentation]]
;; - [[http://gihyo.jp/admin/serial/01/ubuntu-recipe/0247?page=1][第247回　Offlineimap＋Dovecotによる快適メール環境：Ubuntu Weekly Recipe｜gihyo.jp … 技術評論社]]
;; - [[http://piao-tech.blogspot.jp/2010/03/get-offlineimap-working-with-non-ascii.html][私のTech記憶: Get offlineimap working with non ASCII characters.]]

;; *** mu
;; **** muを用いてメールを素早く検索

;; muは，MaildirにあるメールをDB化する．
;; 表示や検索が素早く行えるようになる．
;; 検索が優れているので，ファルダを利用してメールを整理する必要がなくなる．
;; Gmailでラベルを使用していたが，muでの検索機能が優れているので，全て削除した．

;; - mu (maildir-utils)
;;   - [[http://www.djcbsoftware.nl/code/mu/mu4e/index.html#Top][mu4e user manual]]
;;   - [[http://code.google.com/p/mu0/downloads/detail?name=mu4e-manual-0.9.9.pdf][mu4e-manual-0.9.9.pdf - mu0 - mu4e v0.9.9 manual - mu is a collection of utilties for indexing and searching Maildirs - Google Project Hosting]]
;;   - [[https://github.com/djcb/mu][djcb/mu]]
;;   - [[http://www.brool.com/index.php/using-mu4e][Using mu4e | brool]]



;; - インストール
;;   - sudo apt-get install mu4e mildir-utils-extra

;; - mu index

;; こちらは510.57秒．

;; ** Emacsのカスタマイズ
;; - custom.el
;;   (user-mail-address "yoshi@chubachi.net")
;;   (user-full-name  "Yoshihide Chubachi")
;;   (message-signature "Yoshihide Chubachi @AIIT")
;;   (smtpmail-smtp-user "yoshihide.chubachi@gmail.com")

;; - これはよくわからない
;;   '(mu4e-user-mail-address-list (quote ("yc@aiit.ac.jp" "yoshi@chubachi.net" "yoshihide.chubachi@gmail.com")))

;; ** Emacsの設定ファイル
;; *** パッケージの読み込み
;; #+begin_src emacs-lisp
;; ;;  (require 'mu4e)
;; #+end_src

;; *** Gmail用Maildirフォルダの指定
;; mu4eで用いるGmailのフォルダを指定する．
;; GmailのSentフォルダは設定せず，All Mailフォルダを指定する．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-maildir       "~/Maildir")
;; ;;  (setq mu4e-sent-folder   "/[Gmail].All Mail")
;; ;;  (setq mu4e-drafts-folder "/[Gmail].Drafts")
;; ;;  (setq mu4e-trash-folder  "/[Gmail].Trash")
;; ;;  (setq mu4e-refile-folder "/[Gmail].All Mail")
;; #+end_src

;; don't save message to Sent Messages, Gmail/IMAP takes care of this

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-sent-messages-behavior 'delete)
;; #+end_src

;; 	  ;; setup some handy shortcuts
;; 	  ;; you can quickly switch to your Inbox -- press ``ji''
;; 	  ;; then, when you want archive some messages, move them to
;; 	  ;; the 'All Mail' folder by pressing ``ma''.

;; rでrefileしたほうが便利．

;; #+begin_src emacs-lisp
;;   ;; (setq mu4e-maildir-shortcuts
;;   ;;       '( ("/INBOX"             . ?i)
;;   ;;          ("/[Gmail].All Mail"  . ?a)
;;   ;;          ("/[Gmail].Drafts"    . ?d)
;;   ;;          ("/[Gmail].Trash"     . ?t)))
;; #+end_src

;; SMTPの設定．Emacs標準のコンポーネント．

;; #+begin_src emacs-lisp
;;   ;; (require 'smtpmail)
;;   ;; (setq message-send-mail-function 'smtpmail-send-it
;;   ;;       smtpmail-stream-type 'starttls
;;   ;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;   ;;       smtpmail-smtp-server "smtp.gmail.com"
;;   ;;       smtpmail-smtp-service 587)
;; #+end_src

;; - [[http://www.djcbsoftware.nl/code/mu/mu4e/Retrieval-and-indexing.html#Retrieval-and-indexing][Retrieval and indexing - mu4e user manual]]

;;   ;; don't keep message buffers around
;; #+begin_src emacs-lisp
;; ;;  (setq message-kill-buffer-on-exit t)
;; #+end_src


;;   ;; show images
;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-show-images t)
;; #+end_src

;;   ;; use imagemagick, if available
;; #+begin_src emacs-lisp
;; ;;  (when (fboundp 'imagemagick-register-types)
;; ;;    (imagemagick-register-types))

;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-msg2pdf "/usr/bin/msg2pdf")
;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (add-to-list 'mu4e-view-actions
;; ;;		   '("View in browser" . mu4e-action-view-in-browser) t)
;; #+end_src

;; HTML形式のメールをEmacs内で読むためにテキスト形式に整形するための
;; コマンドを指定する．
;; html2textも利用できるが，Shift JISに対応していない．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-html2text-command "w3m -dump -T text/html")
;; #+end_src

;; Gmailでスターをつけると，flagが付く．
;; そこで，これを検索するブックマークを追加する．

;; #+begin_src emacs-lisp
;; ;;  (add-to-list 'mu4e-bookmarks '("flag:flagged" "Flagged (Starred in Gmail)" ?s))
;; #+end_src

;; ヘッダ一覧画面に表示される日付と時刻の表示形式を設定する．
;; 当日のメールにも日付が表示されるようにした．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-headers-date-format "%y-%m-%d %H:%M")
;; ;;  (setq mu4e-headers-time-format "%y-%m-%d %H:%M")
;; #+end_src

;; ヘッダーに表示する列と幅を指定する．

;; #+begin_src emacs-lisp
;;   ;; (setq mu4e-headers-fields
;;   ;;       '((:human-date . 14)
;;   ;;         (:flags . 6)
;;   ;;         (:from . 15)
;;   ;;         (:subject)))
;; #+end_src

;; メールが/INDEXと/[Gmail]/All Mailの両方に存在する状態の場合，
;; 検索結果に両方が含まれる．次の設定をすることにより，
;; 重複を除外して表示する．

;; #+begin_src emacs-lisp
;;   ;;  (setq mu4e-headers-skip-duplicates 't)
;; #+end_src

;; *** org-mode対応

;; #+begin_src emacs-lisp
;; ;;  (require 'org-mu4e)
;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (defalias 'org-mail 'org-mu4e-compose-org-mode)
;; #+end_src

;;   ;; convert org mode to HTML automatically
;; #+begin_src emacs-lisp
;; ;;  (setq org-mu4e-convert-to-html t)
;; #+end_src
;; ** キーバインド

;; #+begin_src emacs-lisp
;; ;;  (global-set-key (kbd "C-c m") 'mu4e)
;; #+end_src
;; * TODO Todo List
;; ** TODO org-insert-heading-respect-contentをC-jにする
;;    :PROPERTIES:
;;    :ID:       f9593ce6-203d-47a7-9342-fd602c193a0c
;;    :END:
;;    C-jはorg-return-indentにバインドされている
;; ** TODO [[http://www.emacswiki.org/emacs/UnitTesting][EmacsWiki: Unit Testing]]
;;    :PROPERTIES:
;;    :ID:       5cb66ace-65c3-4e01-9c1c-f25ae7008668
;;    :END:
;; ** TODO [[https://github.com/purcell/exec-path-from-shell][purcell/exec-path-from-shell]]
;;    :PROPERTIES:
;;    :ID:       cd8617f9-5634-467f-9c14-ca657a802726
;;    :END:
;; ** TODO flyspell-modeでC-.がかちあう
;;    :PROPERTIES:
;;    :ID:       7af985a9-1630-4e8a-8202-3d434351c518
;;    :END:
;; ** TODO [[http://shibayu36.hatenablog.com/entry/2012/12/29/001418][年末emacs設定大掃除をして、これは捨てられないと思った設定書いてく - $shibayu36->blog;]]
;;    :PROPERTIES:
;;    :ID:       e010dd60-ee65-4042-9b16-9ae0f2681837
;;    :END:
;; ** TODO Qiitaに投稿できないか
;;    :PROPERTIES:
;;    :ID:       7cd92222-91c7-4c46-9325-85e891c20216
;;    :END:
;; ** TODO org-modeで候補をインラインにできないか
;;    :PROPERTIES:
;;    :ID:       0d60c33f-5d9b-4447-bf76-8344bf44471c
;;    :END:
;; ** TODO [[http://www.fan.gr.jp/~ring/doc/elisp_19/elisp-jp_39.html][GNU Emacs Lispリファレンス・マニュアル: A. ヒントと標準的な作法]]
;; ** TODO 参考文献

;;  Emacs LISP テクニックバイブル

;; - p.31より
;; ** TODO os-name

;; [[http://wisdom.sakura.ne.jp/programming/lisp/clisp11.html][condとcase]]

;; (defun convert-system-type-to-os-name ()
;;   (cond ((eq system-type 'gnu/linux) 'linux)
;; 	((eq system-type 'darwin) 'osx)
;; 	((eq system-type 'windows-nt) 'windows)
;; 	((eq system-type 'cygwin) 'cygwin)
;; 	(t 'unknown)))

;; (convert-system-type-to-os-name)	; => linux

;; (let (custom-file-system-name)
;;   (setq custom-file-system-name
;; 	(format "custom-%s.el" system-type)) ; => "custom-gnu/linux.el"
;;   (message custom-file-system-name))		   ; => "custom-gnu/linux.el"

;; * TODO PHP

;; #+begin_src emacs-lisp
;;   ;; (dolist (package '(php-mode))
;;   ;;   (when (not (package-installed-p package))
;;   ;;     (package-install package)))
;; #+end_src

;; * TODO markdown
;;   - [[http://jblevins.org/projects/markdown-mode/][Emacs Markdown Mode]]
;;   - 拡張子が.text，.markdown，.mdであるファイルはmarkdown-modeになる
;; 	（markdown-mode-autoloads.el参照）．

;; * TODO mediawiki export
;;   - packageでインストールできなさそう

;; #+NAME: ox-mediawiki
;; #+begin_src emacs-lisp
;;   (use-package ox-mediawiki :ensure t)
;; #+end_src

;; * TODO 開始の通知

;; #+begin_src emacs-lisp
;;  (message "%s" "%% Emacsの設定を開始します %%")
;; #+end_src

;; * TODO ロードパスの設定						 :startup.el:

;; - normal-top-level-add-subdirs-to-load-path は
;;   default-directory の全てのサブディレクトリを load-path に追加する
;;   関数です．

;; - gitのsubmoduleとして管理するライブラリを追加します．

;; #+begin_src emacs-lisp
;;   (let ((default-directory "~/.emacs.d/git/"))
;; 	(normal-top-level-add-subdirs-to-load-path))
;; #+end_src

;; - ソースコードで管理するライブラリを追加します．

;; #+begin_src emacs-lisp
;;   (let ((default-directory "~/.emacs.d/site-lisp/"))
;; 	(normal-top-level-add-subdirs-to-load-path))
;; #+end_src

;; * TODO after-init-hookの設定
;;   - after-init-hookはパッケージの初期化が完了したら呼ばれるフックです．
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/elisp/Init-File.html#Init-File][Init File - GNU Emacs Lisp Reference Manual]]

;; #+begin_src emacs-lisp
;; 	(add-hook 'after-init-hook
;; 		  (lambda ()
;; 		(message "%s" "%% custom.elを読み込みました %%")))
;; #+end_src

;; * TODO Caskの設定
;; #+begin_src emacs-lisp
;; (require 'cask "~/.cask/cask.el")
;; (cask-initialize)
;; #+end_src

;; * TODO WebにHTMLでPublishする 					       :個人設定:
;;    :PROPERTIES:
;;    :ID:       fcdb09c8-3a9a-4ea9-9482-10d445b6db9f
;;    :END:
;;    - customzationに移動する？

;; #+begin_src emacs-lisp
;; (setq org-publish-project-alist
;; 	  '(
;; 	("chubachi.net-notes"
;; 	 :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
;; 	 :base-extension "org"
;; 	 :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
;; 	 :publishing-function org-html-publish-to-html
;; 	 ;; :headline-levels 3
;; 	 ;; :section-numbers nil
;; 	 ;; :with-toc nil
;; 	 ;; :html-head "<link rel=\"stylesheet\"
;; 	 ;;               href=\"../other/mystyle.css\" type=\"text/css\"/>"
;; 	 ;; :html-preamble t
;; 	 :recursive t
;; 	 )
;; 	("chubachi.net-static"
;; 	 :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
;; 	 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
;; 	 :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
;; 	 :recursive t
;; 	 :publishing-function org-publish-attachment
;; 	 )
;; 	("chubachi.net"
;; 	 :components ("chubachi.net-notes" "chubachi.net-static"))
;; 	  ))
;; #+end_src

;; * TODO org-page
;;   - [[https://github.com/kelvinh/org-page][kelvinh/org-page]]
;;   - 新しいリポジトリを作る
;; 	- op/new-repository
;;   ｰ 公開
;; 	- op/do-publication

;; #+begin_src emacs-lisp
;; (require 'org-page)
;; #+end_src

;; * TODO WordPressに記事を投稿（org2blog）
;; ** 利用法
;;   - org2blogを使うと，subtreeをwordpressに投稿できる．
;;   - 使い方は [[https://github.com/punchagan/org2blog][punchagan/org2blog]] を参照．

;;    |--------------------------+--------------------------|
;;    | 機能                     | コマンド                 |
;;    |--------------------------+--------------------------|
;;    | 下位層を投稿             | org2blog/wp-post-subtree |
;;    |--------------------------+--------------------------|
;;    | ログイン                 | org2blog/wp-login        |
;;    | 新規投稿                 | org2blog/wp-new-entry    |
;;    |--------------------------+--------------------------|
;;    | 草稿として投稿           | C-c d                    |
;;    | 公開                     | C-c p                    |
;;    | 草稿として草稿（ページ） | C-c D                    |
;;    | 公開（ページ）           | C-c P                    |
;;    |--------------------------+--------------------------|

;; 1. キャプチャして新しい記事を作成
;; 2. 投稿したいエントリのヘッダにカーソルを移動して
;;    org2blog/wp-new-entry
;;    -> ログインしてなければログインが促される
;; 3. ブラウザで確認

;; ** 導入

;; #+begin_src emacs-lisp
;;   (require 'org2blog-autoloads)
;; #+end_src

;; ** 手動設定

;; - wordpressのログイン情報をcustom.el内に記述

;; ** ソースコードを投稿できるようにする

;; #+begin_src emacs-lisp
;;   (setq org2blog/wp-use-sourcecode-shortcode t)
;; #+end_src

;; ** 備考
;;    - ソースコードを表示させるには
;; 	 [[http://wordpress.org/plugins/syntaxhighlighter/][WordPress › SyntaxHighlighter Evolved « WordPress Plugins]]
;; 	 をインストールしておく．
;;    - emacs lispには対応していない．残念．

;; * TODO system-typeに応じたcustom.el

;; #+begin_src emacs-lisp
;;   (let (custom-file-system-name)
;; 	(setq custom-file-system-name
;; 	  (format "~/.emacs.d/custom/%s.el" (system-name)))
;; 	(when (file-exists-p custom-file-system-name)
;; 	  (message "%s" (format "%sを読み込みます" custom-file-system-name))
;; 	  (load custom-file)))
;; #+end_src

;; * TODO markdownモードでアウトラインを有効にする
;; - markdown-mode-hook 定義されてない？
;; #+begin_src emacs-lisp
;;   (add-hook 'markdown-mode-hook
;; 		'(lambda () (outline-minor-mode t)))
;; #+end_src

;; * TODO Windows用設定
;; ** TODO 設定全体

;; #+begin_src emacs-lisp :noweb yes
;;   (when (or (eq system-type 'windows-nt)
;; 		(eq system-type 'cygwin))
;; 	<<windows-settings>>
;;   )
;; #+end_src

;; ** Windows用設定

;; #+name: windows-settings
;; #+begin_src emacs-lisp :tangle no
;;   (setq file-name-coding-system 'cp932)

;;   ;; Ctrl-gとかでベルを鳴らさないようにします。
;;   (setq visible-bell t)
;;   (setq ring-bell-function 'ignore)

;;   ;;;** 標準IMEの設定
;;   (setq default-input-method "W32-IME")

;;   ;;;** IMEの初期化
;;   (w32-ime-initialize)

;;   ;;;** IME状態のモードライン表示
;;   (setq-default w32-ime-mode-line-state-indicator "[--]")
;;   (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))

;;   ;;;** IME OFF時の初期カーソルカラー
;;   (set-cursor-color "red")

;;   ;;;** IME ON/OFF時のカーソルカラー
;;   (add-hook 'input-method-activate-hook
;; 		(lambda() (set-cursor-color "green")))
;;   (add-hook 'input-method-inactivate-hook
;; 		(lambda() (set-cursor-color "red")))

;;   ;;;** バッファ切り替え時にIME状態を引き継ぐ
;;   (setq w32-ime-buffer-switch-p nil)

;;   ;; ;; cp932エンコード時の表示を「P」とする
;;   ;; (coding-system-put 'cp932 :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-dos :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-unix :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-mac :mnemonic ?P)
;; #+end_src

;; * TODO graphviz-dot-mode
;;   - .dot ファイルをgraphviz-dot-modeで開くようにします．

;; #+begin_src emacs-lisp
;; (setq graphviz-dot-preview-extension "pdf")
;; #+end_src

;; * TODO Helm
;; ** TODO C-k
;; ミニバッファで C-k 入力時にカーソル以降を削除する

;; #+begin_src emacs-lisp
;; (setq helm-delete-minibuffer-contents-from-point t)
;; #+end_src

;; ** TODO 他のパッケージ

;; #+begin_src emacs-lisp
;; (dolist (package '(
;; 		   helm-themes
;; 		   imenu-anywhere
;; 		   helm-c-yasnippet))
;;   (when (not (package-installed-p package))
;; 	(package-install package)))
;; #+end_src

;; #+begin_src emacs-lisp
;; (require 'helm-command)

;; (setq helm-idle-delay             0.1
;; 	  helm-input-idle-delay       0.1
;; 	  helm-candidate-number-limit 200)
;; #+end_src


;; #+begin_src emacs-lisp
;; (require 'helm-imenu)
;; (setq imenu-auto-rescan t)
;; (setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

;; (require 'helm-themes)

;; (require 'helm-c-yasnippet)
;; #+end_src

;;; custum.el
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/data/backup/" t))))
 '(auto-save-list-file-prefix "~/.emacs.d/data/auto-save-list/saves-")
 '(backup-directory-alist (quote (("\\.*$" . "~/.emacs.d/data/backup"))))
 '(bookmark-default-file "~/.emacs.d/data/bookmarks")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist
   (quote
    (("YC's MediaWiki" "http://wiki.chubachi.net/" "yc" "" "メインページ"))))
 '(message-signature "Yoshihide Chubachi @AIIT")
 '(mouse-drag-copy-region t)
 '(mouse-yank-at-point t)
 '(mu4e-attachment-dir "~/Downloads")
 '(mu4e-user-mail-address-list
   (quote
    ("yc@aiit.ac.jp" "yoshi@chubachi.net" "yoshihide.chubachi@gmail.com")))
 '(op/repository-directory "/home/yc/git/ychubachi.github.io")
 '(op/site-domain "http://ychubachi.github.io/")
 '(org-export-in-background nil)
 '(org-log-done (quote time))
 '(org-src-fontify-natively t)
 '(org2blog/wp-blog-alist
   (quote
    (("blog.chubachi.net" :url "http://blog.chubachi.net/xmlrpc.php" :username "yc" :password "6mX6fj4p2kZZ"))))
 '(outline-minor-mode-prefix "")
 '(recentf-max-menu-items 25)
 '(send-mail-function (quote smtpmail-send-it))
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-z")
 '(shell-pop-window-height 30)
 '(show-paren-mode t)
 '(smtpmail-smtp-user "yoshihide.chubachi@gmail.com")
 '(user-full-name "Yoshihide Chubachi")
 '(user-mail-address "yc@aiit.ac.jp"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal))))
 '(org-column-title ((t (:background "grey30" :underline t :weight bold :height 135)))))
