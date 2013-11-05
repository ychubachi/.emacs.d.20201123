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
(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$latex=q/platex %S/' -e '$bibtex=q/pbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvips=q/dvips -Ppdf -z -f %S | convbkmk -g > %D/' -e '$ps2pdf=q/ps2pdf %S %D/' -norc -gg -pdfps %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvipdf=q/dvipdfmx -o %D %S/' -norc -gg -pdfdvi %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$latex=q/uplatex %S/' -e '$bibtex=q/upbibtex %B/' -e '$makeindex=q/mendex -o %D %S/' -e '$dvips=q/dvips -Ppdf -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %S %D/' -norc -gg -pdfps %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$pdflatex=q/pdflatex %S/' -e '$bibtex=q/bibtex %B/' -e '$makeindex=q/makeindex -o %D %S/' -norc -gg -pdf %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$pdflatex=q/lualatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$makeindex=q/texindy -o %D %S/' -norc -gg -lualatex %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$pdflatex=q/luajitlatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$makeindex=q/texindy -o %D %S/' -norc -gg -lualatex %f"))
;(setq org-latex-pdf-process '("/usr/texbin/latexmk -e '$pdflatex=q/xelatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$makeindex=q/texindy -o %D %S/' -norc -gg -xelatex %f"))
;(setq org-export-in-background t)
(setq org-file-apps
      '(("pdf" . "/usr/bin/open -a Preview.app %s")))

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

(add-to-list 'org-latex-classes
             '("jsarticle-dvips"
               "\\ifdefined\\ucs
  \\documentclass[uplatex,12pt,a4paper,papersize,dvips]{jsarticle}
\\else
  \\documentclass[12pt,a4paper,papersize,dvips]{jsarticle}
\\fi
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\hypersetup{setpagesize=false,colorlinks=true}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

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
             '("bxjsarticle"
               "\\ifdefined\\kanjiskip
  \\ifdefined\\ucs
    \\documentclass[uplatex,12pt,a4paper,jadriver=standard]{bxjsarticle}
  \\else
    \\documentclass[platex,12pt,a4paper,jadriver=standard]{bxjsarticle}
  \\fi
\\else
  \\ifdefined\\XeTeXversion
    \\documentclass[xelatex,12pt,a4paper,jadriver=standard]{bxjsarticle}
  \\else
    \\ifdefined\\directlua
      \\documentclass[lualatex,12pt,a4paper,jadriver=standard]{bxjsarticle}
    \\else
      \\documentclass[pdflatex,12pt,a4paper,jadriver=standard]{bxjsarticle}
    \\fi
  \\fi
\\fi
[NO-DEFAULT-PACKAGES]
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\ifdefined\\kanjiskip
  \\usepackage[dvipdfmx]{graphicx}
  \\usepackage[dvipdfmx]{hyperref}
  \\usepackage{pxjahyper}
\\else
  \\ifdefined\\XeTeXversion
    \\usepackage[xetex]{graphicx}
    \\usepackage[xetex]{hyperref}
  \\else
    \\usepackage{graphicx}
    \\usepackage{hyperref}
  \\fi
\\fi
\\ifdefined\\directlua
  \\hypersetup{pdfencoding=auto,colorlinks=true}
\\else
  \\usepackage[whole,autotilde]{bxcjkjatype}
  \\hypersetup{unicode,colorlinks=true}
\\fi
\\ifdefined\\XeTeXversion
  \\usepackage{zxjatype}
  \\setjamainfont{ipaexm.ttf}
  \\setjasansfont{ipaexg.ttf}
  \\setjamonofont{ipaexg.ttf}
\\fi
\\ifdefined\\directlua
  \\usepackage{luatexja}
\\fi"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
;;; 30-org-mode.el ends here
