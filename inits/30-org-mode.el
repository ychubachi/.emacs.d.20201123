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
;;; 30-org-mode.el ends here
