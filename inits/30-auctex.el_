;;
;; AUCTeX
;;
(setq japanese-LaTeX-default-style "jsarticle")
(setq TeX-engine-alist '((ptex "pTeX" "ptex2pdf -e -ot '%S %(mode)'" "ptex2pdf -l -ot '%S %(mode)'" "eptex")
                         (uptex "upTeX" "ptex2pdf -e -u -ot '%S %(mode)'" "ptex2pdf -l -u -ot '%S %(mode)'" "euptex")))
(setq TeX-engine 'ptex)
(setq TeX-view-program-selection '((output-pdf "Evince")))
;(setq TeX-view-program-selection '((output-pdf "Okular")))
(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook
          (function (lambda ()
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX" "platex %S %(mode) %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfpLaTeX2" "platex %S %(mode) %t && dvips -Ppdf -z -f %d | convbkmk -g > %f && ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run pLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX" "uplatex %S %(mode) %t && dvipdfmx %d"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX and dvipdfmx"))
                      (add-to-list 'TeX-command-list
                                   '("pdfupLaTeX2" "uplatex %S %(mode) %t && dvips -Ppdf -z -f %d | convbkmk -u > %f && ps2pdf %f"
                                     TeX-run-TeX nil (latex-mode) :help "Run upLaTeX, dvips, and ps2pdf"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk" "latexmk %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfpLaTeX" "latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfpLaTeX2" "latexmk -e '$latex=q/platex %S %(mode)/' -e '$bibtex=q/pbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -g > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfpLaTeX2"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfupLaTeX" "latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfupLaTeX2" "latexmk -e '$latex=q/uplatex %S %(mode)/' -e '$bibtex=q/upbibtex/' -e '$makeindex=q/mendex/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX2"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-pdfLaTeX" "latexmk -e '$pdflatex=q/pdflatex %S %(mode)/' -e '$bibtex=q/bibtex/' -e '$makeindex=q/makeindex/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-LuaLaTeX" "latexmk -e '$pdflatex=q/lualatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-LuaJITLaTeX" "latexmk -e '$pdflatex=q/luajitlatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -pdf %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("Latexmk-XeLaTeX" "latexmk -e '$pdflatex=q/xelatex %S %(mode)/' -e '$bibtex=q/bibtexu/' -e '$makeindex=q/texindy/' -norc -gg -xelatex %t"
                                     TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      (add-to-list 'TeX-command-list
                                   '("pBibTeX" "pbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run pBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("upBibTeX" "upbibtex %s"
                                     TeX-run-BibTeX nil t :help "Run upBibTeX"))
                      (add-to-list 'TeX-command-list
                                   '("BibTeXu" "bibtexu %s"
                                     TeX-run-BibTeX nil t :help "Run BibTeXu"))
                      (add-to-list 'TeX-command-list
                                   '("Mendex" "mendex %s"
                                     TeX-run-command nil t :help "Create index file with mendex"))
                      (add-to-list 'TeX-command-list
                                   '("Evince" "evince %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Evince"))
                      (add-to-list 'TeX-command-list
                                   '("fwdevince" "fwdevince %s.pdf %n \"%b\""
                                     TeX-run-discard-or-function t t :help "Forward search with Evince"))
                      (add-to-list 'TeX-command-list
                                   '("Okular" "okular --unique \"file:\"%s.pdf\"#src:%n %a\""
                                     TeX-run-discard-or-function t t :help "Forward search with Okular"))
                      (add-to-list 'TeX-command-list
                                   '("zathura" "zathura -s -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run zathura"))
                      (add-to-list 'TeX-command-list
                                   '("qpdfview" "qpdfview --unique \"\"%s.pdf\"#src:%b:%n:0\""
                                     TeX-run-discard-or-function t t :help "Forward search with qpdfview"))
                      (add-to-list 'TeX-command-list
                                   '("PdfViewer" "pdfviewer \"file:\"%s.pdf\"#src:%n %b\""
                                     TeX-run-discard-or-function t t :help "Forward search with PdfViewer"))
                      (add-to-list 'TeX-command-list
                                   '("TeXworks" "texworks %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                   '("MuPDF" "mupdf %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run MuPDF"))
                      (add-to-list 'TeX-command-list
                                   '("Firefox" "firefox -new-window %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
                      (add-to-list 'TeX-command-list
                                   '("Chromium" "chromium --new-window %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Chromium"))
                      (add-to-list 'TeX-command-list
                                   '("acroread" "acroread %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader"))
                      (add-to-list 'TeX-command-list
                                   '("pdfopen" "pdfopen -viewer ar9-tab %s.pdf"
                                     TeX-run-discard-or-function t t :help "Run Adobe Reader")))))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)
