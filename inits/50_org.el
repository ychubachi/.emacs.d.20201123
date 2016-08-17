;;; Org（ここに集約する）

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


;; 2016-07-31:(use-package ox-reveal :ensure t) <- エラー

;;; Org関連のディレクトリ
(setq org-agenda-files (quote ("~/Dropbox/Org/")))
(setq org-default-notes-file "~/Dropbox/Org/notes.org")
(setq org-directory "~/Dropbox/Org")

;;; orgのキャプチャ設定
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

;; LaTeXでエキスポートできるようにします．
;; 下記URLのコードから，xelatex用の設定を抜き出しました．

;; − [[http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Emacs%2FOrg%20mode#h20d131a][Emacs/Org mode - TeX Wiki]] （2014-08-03 参照）

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

;;  パッケージの読み込み
;;  文書クラスの設定(beamer)

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

;;; LaTeXでソースコードのエクスポート
(defun my/org-minted ()
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
        '(("frame" "single") ("linenos" "true"))))

;;; org-mode 用 smartrep
(defun my/smartrep ()
  (use-package smartrep
    :init
    (smartrep-define-key
	org-mode-map
	"C-c" '(("C-n" . (lambda ()
			   (outline-next-visible-heading 1)))
		("C-p" . (lambda ()
			   (outline-previous-visible-heading 1)))))
    :ensure t))

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
    (setq org-babel-load-languages	;Babelで対応する言語
	  (quote
	   ((emacs-lisp . t)
	    (dot . t)
	    (java . t)
	    (ruby . t)
	    (sh . t))))
    (setq org-babel-sh-command "bash")	;BabelのShellのコードの実行にbashを使う
    (setq org-deadline-warning-days 7) 	;期日の何日前に予定表（Agenda）に表示するか

    ;; - [[http://orgmode.org/manual/Matching-tags-and-properties.html][Matching tags and properties - The Org Manual]]
    ;; - [[https://www.gnu.org/software/emacs/manual/html_node/org/Special-agenda-views.html][Special agenda views - The Org Manual]]
    (setq org-agenda-custom-commands	;予定表生成追加命令
	  (quote
	   (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
	    ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
	    ("p" "私用" tags-todo "+私用" nil)
	    ("P" "私用以外" tags-todo "-私用" nil)
	    ("n" "Agenda and all TODO's" ((agenda "" nil)
					  (alltodo "" nil)) nil))))
    (setq org-confirm-babel-evaluate nil)

    ;; - [[https://github.com/matburt/mobileorg-android/wiki][Home · matburt/mobileorg-android Wiki]]
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
    (my/org-minted)


    ;;   - [[http://orgmode.org/worg/org-contrib/org-protocol.html#sec-3-6][org-protocol.el – Intercept calls from emacsclient to trigger custom actions]]

    ;;   - C-c C-lでOrg形式のリンク挿入?
    ;;   - [[http://stackoverflow.com/questions/7464951/how-to-make-org-protocol-work][firefox - How to make org-protocol work? - Stack Overflow]]
    ;; 	- gistで公開してあげようかな
    ;;   - [[http://d.hatena.ne.jp/reppets/20111109/1320846292][Unityランチャーに自分でインストール/ビルドしたアプリケーションを登録する - reppets.log.1]]
    ;;   - [[http://kb.mozillazine.org/Register_protocol#Linux][Register protocol - MozillaZine Knowledge Base]]
    ;;   - [[http://orgmode.org/worg/org-contrib/org-protocol.html#sec-3-6]]
    ;; 	- 古い
    (require 'org-protocol))
  :config
  (progn
    ;; - [[http://superuser.com/questions/299886/linewrap-in-org-mode-of-emacs][Linewrap in Org-mode of Emacs? - Super User]]
    (bind-key "M-q" 'toggle-truncate-lines org-mode-map)

    ;; - eval-after-loadにより，orgがロードされた後，
    ;;   もしくは，既にロードされていれば即，実行する．
    ;; - TODO smartrepは既にrequireされている前提
    (my/smartrep))
  :ensure t)
