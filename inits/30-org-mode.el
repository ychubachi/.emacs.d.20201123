;;; 30-org-mode.el -- Org mode
;;; Commentary:

;; org-modeはsubmoduleとしてインストールします

;;; Code:

;; ================================================================
;; Markdown export
;; ================================================================
(require 'ox-md)

;; ================================================================
;; LaTeX export
;; ================================================================
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

;; beamer
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

;; ================================================================
;; Publishing
;; ================================================================

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

;; ================================================================
;; Use bash
;; ================================================================

(setq org-babel-sh-command "bash")

;; ================================================================
;; org2blog
;; ================================================================
(dolist (package '(xml-rpc metaweblog))
  (when (not (package-installed-p package))
    (package-install package)))
(require 'xml-rpc)
(require 'metaweblog)

(setq load-path (cons "~/.emacs.d/lisp/org2blog/" load-path))
(require 'org2blog-autoloads)

(setq org2blog/wp-blog-alist
      '(("cocreative"
         :url "http://www.co-creative.biz/xmlrpc.php"
         :username "yc"
         :default-title "Hello World"
         :default-categories ("org2blog" "emacs")
         :tags-as-categories nil)
	))

;;; 30-org-mode.el ends here
