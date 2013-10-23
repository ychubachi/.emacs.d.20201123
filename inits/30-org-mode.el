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
(require 'ox-beamer)

(setq org-export-in-background nil)

(cond ((eq system-type 'gnu/linux)
       (setq org-latex-pdf-process '("latexmk             -e '$pdflatex=q/lualatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$makeindex=q/texindy -o %D %S/' -norc -gg -lualatex %f"))
       (setq org-file-apps '(("pdf" . "evince %s"))))
      ((eq system-type 'darwin)
       (setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$pdflatex=q/lualatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$makeindex=q/texindy -o %D %S/' -norc -gg -lualatex %f"))
       (setq org-file-apps '(("pdf" . "/usr/bin/open -a Skim %s")))))

(setq org-latex-default-class "ltjsarticle")

(add-to-list 'org-latex-classes
             '("ltjsarticle"
                     "\\documentclass[12pt,a4paper]{ltjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\hypersetup{pdfencoding=auto,colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass[presentation]{beamer}
[NO-DEFAULT-PACKAGES]
\\usepackage{luatexja}
\\usepackage[ipa]{luatexja-preset}
\\usepackage[utf8]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage{fixltx2e}
\\usepackage{graphicx}
\\usepackage{longtable}
\\usepackage{float}
\\usepackage{wrapfig}
\\usepackage[normalem]{ulem}
\\usepackage{textcomp}
\\usepackage{marvosym}
\\usepackage{wasysym}
\\usepackage{latexsym}
\\usepackage{amssymb}
\\usepackage{amstext}
\\usepackage{hyperref}
\\hypersetup{pdfencoding=auto,colorlinks=true}
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
