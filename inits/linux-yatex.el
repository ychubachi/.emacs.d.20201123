;;; linux-yatex.el --- YaTeX
;;; Commentary:
;;; Code:
(setq YaTeX-dvi2-command-ext-alist
      '(("texworks\\|evince\\|okular\\|zathura\\|qpdfview\\|pdfviewer\\|mupdf\\|xpdf\\|firefox\\|chromium\\|acroread\\|pdfopen" . ".pdf")))
(setq tex-command "ptex2pdf -l -ot '-synctex=1'")
;(setq tex-command "ptex2pdf -l -u -ot '-synctex=1'")
;(setq tex-command "pdfplatex")
;(setq tex-command "pdfplatex2")
;(setq tex-command "pdfuplatex")
;(setq tex-command "pdfuplatex2")
;(setq tex-command "pdflatex -synctex=1")
;(setq tex-command "lualatex -synctex=1")
;(setq tex-command "luajitlatex -synctex=1")
;(setq tex-command "xelatex -synctex=1")
;(setq tex-command "latexmk")
;(setq tex-command "latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e '$latex=q/platex %O -synctex=1 %S/' -e '$bibtex=q/pbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -g > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
;(setq tex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvipdf=q/dvipdfmx %O -o %D %S/' -norc -gg -pdfdvi")
;(setq tex-command "latexmk -e '$latex=q/uplatex %O -synctex=1 %S/' -e '$bibtex=q/upbibtex %O %B/' -e '$makeindex=q/mendex %O -o %D %S/' -e '$dvips=q/dvips %O -z -f %S | convbkmk -u > %D/' -e '$ps2pdf=q/ps2pdf %O %S %D/' -norc -gg -pdfps")
;(setq tex-command "latexmk -e '$pdflatex=q/pdflatex %O -synctex=1 %S/' -e '$bibtex=q/bibtex %O %B/' -e '$makeindex=q/makeindex %O -o %D %S/' -norc -gg -pdf")
;(setq tex-command "latexmk -e '$pdflatex=q/lualatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
;(setq tex-command "latexmk -e '$pdflatex=q/luajitlatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -lualatex")
;(setq tex-command "latexmk -e '$pdflatex=q/xelatex %O -synctex=1 %S/' -e '$bibtex=q/bibtexu %O %B/' -e '$makeindex=q/texindy %O -o %D %S/' -norc -gg -xelatex")
(setq bibtex-command (cond ((string-match "uplatex\\|-u" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex")
                           ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "bibtexu")
                           ((string-match "pdflatex\\|latex" tex-command) "bibtex")
                           (t "pbibtex")))
(setq makeindex-command (cond ((string-match "uplatex\\|-u" tex-command) "mendex")
                              ((string-match "platex" tex-command) "mendex")
                              ((string-match "lualatex\\|luajitlatex\\|xelatex" tex-command) "texindy")
                              ((string-match "pdflatex\\|latex" tex-command) "makeindex")
                              (t "mendex")))

(setq dvi2-command "evince")
;(setq dvi2-command "okular --unique")
;(setq dvi2-command "zathura -s -x \"emacsclient --no-wait +%{line} %{input}\"")
;(setq dvi2-command "qpdfview --unique")
;(setq dvi2-command "pdfviewer")
;(setq dvi2-command "texworks")
;(setq dvi2-command "mupdf")
;(setq dvi2-command "firefox -new-window")
;(setq dvi2-command "chromium --new-window")
(setq dviprint-command-format "acroread `echo %s | sed -e \"s/\\.[^.]*$/\\.pdf/\"`")

(defun evince-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "fwdevince"
      nil
      "fwdevince"
      (expand-file-name
       (concat (file-name-sans-extension (or YaTeX-parent-file
                                             (save-excursion
                                               (YaTeX-visit-main t)
                                               buffer-file-name)))
               ".pdf"))
      (number-to-string (save-restriction
                          (widen)
                          (count-lines (point-min) (point))))
      (buffer-name)))))

(require 'dbus)

(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))

(defun evince-inverse-search (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(dbus-register-signal
 :session nil "/org/gnome/evince/Window/0"
 "org.gnome.evince.Window" "SyncSource"
 'evince-inverse-search)

(defun okular-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "okular"
      nil
      "okular"
      "--unique"
      (concat (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              (buffer-file-name))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c o") 'okular-forward-search)))

(defun qpdfview-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "qpdfview"
      nil
      "qpdfview"
      "--unique"
      (concat (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (buffer-name)
              ":"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              ":0")))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c q") 'qpdfview-forward-search)))

(defun pdfviewer-forward-search ()
  (interactive)
  (progn
    (process-kill-without-query
     (start-process
      "pdfviewer"
      nil
      "pdfviewer"
      (concat "file:"
              (expand-file-name
               (concat (file-name-sans-extension (or YaTeX-parent-file
                                                     (save-excursion
                                                       (YaTeX-visit-main t)
                                                       buffer-file-name)))
                       ".pdf"))
              "#src:"
              (number-to-string (save-restriction
                                  (widen)
                                  (count-lines (point-min) (point))))
              " "
              (buffer-name))))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c p") 'pdfviewer-forward-search)))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode -1)))

;;; linux-yatex.el ends here
