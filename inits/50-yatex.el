;; yatex
(require 'yatex)
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)

;; See http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#j78164d5
(setq YaTeX-kanji-code nil)
(setq tex-command "platex -synctex=1")
(setq bibtex-command (cond ((string-match "uplatex" tex-command) "upbibtex")
                           ((string-match "platex" tex-command) "pbibtex")
                           ((string-match "lualatex\\|xelatex" tex-command) "bibtexu")
                           (t "bibtex")))
(add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode t) (setq fill-column 70)))
;; Outline minor mode for YaTeX
;; See http://www.math.s.chiba-u.ac.jp/~matsu/emacs/emacs20/outline.html
(setq outline-minor-mode-prefix "\C-c\C-o")

(add-hook 'yatex-mode-hook
          '(lambda () (outline-minor-mode t)))

(make-variable-buffer-local 'outline-regexp)
(add-hook
 'yatex-mode-hook
 (function
  (lambda ()
    (progn
      (setq outline-level 'latex-outline-level)
      (setq outline-regexp
            (concat "[ \t]*\\\\\\(documentstyle\\|documentclass\\|"
                    "chapter\\|section\\|subsection\\|subsubsection\\)"
                    "\\*?[ \t]*[[{]")
     )))))

(make-variable-buffer-local 'outline-level)
(setq-default outline-level 'outline-level)
(defun latex-outline-level ()
  (save-excursion
    (looking-at outline-regexp)
    (let ((title (buffer-substring (match-beginning 1) (match-end 1))))
      (cond ((equal (substring title 0 4) "docu") 15)
            ((equal (substring title 0 4) "chap") 0)
            ((equal (substring title 0 4) "appe") 0)
            (t (length title))))))

;; IPA Fonts
(setq YaTeX-dvipdf-command "dvipdfmx -f ptex-ipa")

;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#h118b5e5
(defun evince-forward-search ()
  (interactive)
  (let* ((ctf (buffer-name))
         (mtf)
         (pf)
         (ln (format "%d" (line-number-at-pos)))
         (cmd "fwdevince")
         (args))
    (if (YaTeX-main-file-p)
        (setq mtf (buffer-name))
      (progn
        (if (equal YaTeX-parent-file nil)
            (save-excursion
              (YaTeX-visit-main t)))
        (setq mtf YaTeX-parent-file)))
    (setq pf (concat (car (split-string mtf "\\.")) ".pdf"))
    (setq args (concat "\"" pf "\" " ln " \"" ctf "\""))
    (message (concat cmd " " args))
    (process-kill-without-query
     (start-process-shell-command "fwdevince" nil cmd args))))

(add-hook 'yatex-mode-hook
          '(lambda ()
             (define-key YaTeX-mode-map (kbd "C-c e") 'evince-forward-search)))

;; BibTeX
(add-hook 'bibtex-mode-hook
	  '(lambda ()
	     (outline-minor-mode)))
