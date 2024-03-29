;;; Org（ここに集約する）

;; - マニュアル
;;   - [[http://orgmode.org/org.html][The Org Manual]]
;;   - [[http://orgmode.org/elpa.html][Org Emacs lisp Package Archive]]


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

;; 参考文献
;; - Emacs/Org mode - TeX Wiki
;;   https://texwiki.texjp.org/?Emacs%2FOrg%20mode
;; - org-mode で日本語LaTeXを出力する方法 - Qiita
;;   http://qiita.com/kawabata@github/items/1b56ec8284942ff2646b

(defun my/ox-latex ()
  (require 'ox-latex)

  ;; LaTeXエンジンにXeLaTeXを設定します
  ;; - pdfのインクルードが容易
  ;; - 他のエンジンでは下線の箇所を改行してくれない
  ;; - \includesvgはできない
  (setq
   org-latex-pdf-process
   `(,(concat
       "latexmk -e '$pdflatex=q/xelatex -shell-escape %S/' "
       "-e '$bibtex=q/upbibtex %B/' "
       "-e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' "
       "-e '$makeindex=q/upmendex -o %D %S/' "
       "-norc -gg -pdf %f")))

  ;; 標準のクラスファイルを設定
  ;; - bxjsarticleは各種LaTeXエンジンに対応したクラスファイル
  ;; - geometryパッケージは利用できず，\setpagelayoutを利用する
  ;;   - http://zrbabbler.sp.land.to/bxjscls.html#ssec-g-layout
  (setq org-latex-default-class "bxjsarticle")

  ;; bxjsarticleの設定
  ;; - クラスに設定できるプレースホルダについては次のとおり．
  ;;   [DEFAULT-PACKAGES]      \usepackage statements for default packages
  ;;   [NO-DEFAULT-PACKAGES]   do not include any of the default packages
  ;;   [PACKAGES]              \usepackage statements for packages
  ;;   [NO-PACKAGES]           do not include the packages
  ;;   [EXTRA]                 the stuff from #+LATEX_HEADER(_EXTRA)
  ;;   [NO-EXTRA]              do not include #+LATEX_HEADER(_EXTRA) stuff
  (add-to-list 'org-latex-classes
             '("bxjsarticle"
               "\\documentclass[xelatex,ja=standard,jbase=11Q,a4paper]{bxjsarticle}
[DEFAULT-PACKAGES]
\\hypersetup{colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; Times を TeX 用に配置し直した TX フォント
  ;; - txfonts.sty: LaTeX パッケージ
  ;;   http://www.biwako.shiga-u.ac.jp/sensei/kumazawa/tex/txfonts.html
  ;; - 英文字の横幅が少し詰まる
  (add-to-list 'org-latex-packages-alist '("" "txfonts") t)

  ;; ソースコードの整形にmintedを利用
  (setq org-latex-listings 'minted)
  (add-to-list 'org-latex-packages-alist '("" "minted") t)
  (setq org-latex-minted-options
        '(("frame" "single") ("linenos" "true") ("numbersep" "3pt")
	  ("fontfamily" "courier") ("breaklines" "true")))

  ;; XeLaTeXでは利用できない
  ;; (add-to-list 'org-latex-packages-alist '("" "svg") t)

  ;; TODO: TikZ
  ;; #+LATEX_HEADER: \usetikzlibrary{positioning}
  (add-to-list 'org-latex-packages-alist '("" "tikz") t)
)

;;; my/ox-beamer
(defun my/ox-beamer ()
  (require 'ox-beamer)

  ;; フレームにするセクションのレベル（#+OPTIONS: H:2）
  (setq org-beamer-frame-level 2)

  ;; Outlineのタイトルを目次にします
  (setq org-beamer-outline-frame-title "目次")

  ;; Beamer用クラスの設定（3階層用）
  (add-to-list 'org-latex-classes
               '("beamer"
                 "\\documentclass[xelatex,14pt,presentation,t]{beamer}
\\XeTeXgenerateactualtext=1
\\usepackage{zxjatype}
\\setjamainfont{IPAexMincho}
\\setjasansfont{IPAexGothic}
\\setjamonofont{IPAexGothic}
[DEFAULT-PACKAGES]
\\hypersetup{colorlinks=true}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))

  ;; Beamer用クラスの設定（4階層用）
  (add-to-list 'org-latex-classes
               '("beamer-part"
                 "\\documentclass[xelatex,14pt,presentation,t]{beamer}
\\XeTeXgenerateactualtext=1
\\usepackage{zxjatype}
\\setjamainfont{IPAexMincho}
\\setjasansfont{IPAexGothic}
\\setjamonofont{IPAexGothic}
[DEFAULT-PACKAGES]
\\hypersetup{colorlinks=true}"
                 ("\\part{%s}" . "\\part*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
)

;;; org-mode 用 smartrep
(defun my/smartrep ()
  (use-package smartrep
    :config
    (smartrep-define-key
	org-mode-map
	"C-c" '(("C-n" . (lambda ()
			   (outline-next-visible-heading 1)))
		("C-p" . (lambda ()
			   (outline-previous-visible-heading 1)))))
    :ensure t))

;;; my/org-publish
;; WebにHTMLでPublishする

;; - Publishing Org-mode files to HTML
;;   http://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html
(defun my/org-publish ()
  (require 'ox-publish)
  (setq org-publish-project-alist
	'(
	  ("org-notes"
	   :base-directory "~/Dropbox/Org/Publish/org"
           :base-extension "org"
           :publishing-directory "~/Dropbox/Org/Publish/public_html/"
           :recursive t
           :publishing-function org-html-publish-to-html
	   :body-only t
           )
	  ("org-static"
	   :base-directory "~/Dropbox/Org/Publish/org"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :publishing-directory "~/Dropbox/Org/Publish/public_html/"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	  ("org"
	   :components ("org-notes" "org-static"))

	  ;; www.chubachi.net
	  ("www-notes"
	   :base-directory       "~/git/www_chubachi_net/org"
           :publishing-directory "~/git/www_chubachi_net/source/"
           :base-extension "org"
           :recursive t
           :publishing-function org-html-publish-to-html
	   :section-numbers nil
	   :with-toc nil
	   :with-sub-superscript nil
	   :body-only t
	   :html-extension "html.erb"
	   :headline-levels 3
           )
	  ("www-static"
	   :base-directory       "~/git/www_chubachi_net/org"
	   :publishing-directory "~/git/www_chubachi_net/source/"
	   :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
	   :recursive t
	   :publishing-function org-publish-attachment
	   )
	  ("www"
	   :components ("www-notes" "www-static")
	   )
	  )
	)
  )

;;; org-mode 本体
(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c c" . org-capture)
   ("C-c a" . org-agenda))
  :init
  (progn
    ;; キャプチャのテンプレート
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
    (setq org-babel-sh-command "bash")	; BabelのShellコードの実行にbashを使う
    (setq org-confirm-babel-evaluate nil) ; ブロックの評価時の確認を無効に

    ;; アジェンダ機能の設定
    (setq org-deadline-warning-days 7) 	;期日の何日前にAgendaに表示するか
    (setq org-agenda-custom-commands	;予定表生成追加命令
	  (quote
	   (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
	    ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
	    ("p" "私用" tags-todo "+私用" nil)
	    ("P" "私用以外" tags-todo "-私用" nil)
	    ("n" "Agenda and all TODO's" ((agenda "" nil)
					  (alltodo "" nil)) nil))))

    ;; MobileOrgの設定
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
    ;; HTMLのexport用
;;    (use-package htmlize)

    ;; linerapの設定
    (bind-key "M-q" 'toggle-truncate-lines org-mode-map)

    ;; - TODO smartrepは既にrequireされている前提
    (my/smartrep))

  ;; org-publish
    (my/org-publish)
  :ensure t)
