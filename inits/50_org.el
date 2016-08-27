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

;;; LaTeXでエキスポート

;; OrgからLaTeXにエクスポートするための設定です．

;; クラスに設定できるプレースホルダについては次のとおり．
;;   [DEFAULT-PACKAGES]      \usepackage statements for default packages
;;   [NO-DEFAULT-PACKAGES]   do not include any of the default packages
;;   [PACKAGES]              \usepackage statements for packages
;;   [NO-PACKAGES]           do not include the packages
;;   [EXTRA]                 the stuff from #+LATEX_HEADER(_EXTRA)
;;   [NO-EXTRA]              do not include #+LATEX_HEADER(_EXTRA) stuff

;; 参考文献
;; - Emacs/Org mode - TeX Wiki
;;   https://texwiki.texjp.org/?Emacs%2FOrg%20mode
;; - org-mode で日本語LaTeXを出力する方法 - Qiita
;;   http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b

(defun my/ox-latex ()
  (require 'ox-latex)

  ;; PDFの生成のためにupLaTeXを利用するlatexmkの設定
  ;; - minted等のために-shell-escapeオプションを設定
  (setq
   org-latex-pdf-process
   `(,(concat
       "latexmk "
       "-e '$latex=q/uplatex -shell-escape %S/' "
       "-e '$bibtex=q/upbibtex %B/' "
       "-e '$biber=q/biber "
       "--bblencoding=utf8 -u -U --output_safechars %B/' "
       "-e '$makeindex=q/upmendex -o %D %S/' "
       "-e '$dvipdf=q/dvipdfmx "
       "-o %D %S/' -norc -gg -pdfdvi %f")))

  ;; 標準のLaTeXクラスを削除
  ;; (setq org-latex-classes nil)

  ;; PDFの目次の日本語文字化け対策
  (add-to-list 'org-latex-packages-alist '("" "pxjahyper") t)

  ;; ソースコードの整形にmintedを利用
  (add-to-list 'org-latex-packages-alist '("" "minted") t)
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options
        '(("frame" "single") ("linenos" "true")))

  ;; upLaTeX用jsarticleを標準のクラスファイルに設定
  (setq org-latex-default-class "ujsarticle")

  ;; upLaTeX用jsarticleの設定（fvipdfmxを使用）
  (add-to-list 'org-latex-classes
               '("ujsarticle"
                 "\\documentclass[uplatex,dvipdfmx]{jsarticle}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; 縦書きモード
  ;; - mintedが使えないので[NO-PACKAGES]を指定し，pxjahyperのみ使用
  (add-to-list 'org-latex-classes
	       '("utarticle"
		 "\\documentclass[uplatex,dvipdfmx]{utarticle}
[DEFAULT-PACKAGES]
[NO-PACKAGES]
[EXTRA]
\\usepackage{pxjahyper}"
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
                 "\\documentclass[uplatex,dvipdfmx,presentation,14pt]{beamer}
% ゴシック体
\\renewcommand{\\kanjifamilydefault}{\\gtdefault}
% ナビゲーション表示消去
\\setbeamertemplate{navigation symbols}{}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  (add-to-list 'org-latex-classes
               '("beamer_lecture"
                 "\\documentclass[t]{beamer}
[NO-DEFAULT-PACKAGES]
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
}

\\renewcommand{\\kanjifamilydefault}{\\gtdefault}"
                   ("\\part{%s}" . "\\part*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))

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
    ;;  Babelの設定
    (setq org-babel-load-languages	;Babelで対応する言語
	  (quote
	   ((emacs-lisp . t)
	    (dot . t)
	    (java . t)
	    (ruby . t)
	    (sh . t))))
    (setq org-babel-sh-command "bash")	;BabelのShellのコードの実行にbashを使う
    (setq org-deadline-warning-days 7) 	;期日の何日前にAgendaに表示するか

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
     '(org-src-fontify-natively t))
    (require 'ox-md)

    ;; エクスポート関係
    (setq org-export-in-background nil)	; tにすると時間がかかる
    (my/ox-latex)
    (my/ox-beamer)

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
