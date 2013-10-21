;;; 40-yatex.el --- YaTeX
;;; Commentary:
;;; Code:
(global-set-key (kbd "C-c C-t") nil)

;; ================================================================
;; YaTeX - TeX Wiki
;; - http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?YaTeX#nec42ee2
;; ================================================================
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq auto-mode-alist
      (append '(("\\.tex$" . yatex-mode)
                ("\\.ltx$" . yatex-mode)
                ("\\.cls$" . yatex-mode)
                ("\\.sty$" . yatex-mode)
                ("\\.clo$" . yatex-mode)
                ("\\.bbl$" . yatex-mode)) auto-mode-alist))
(setq YaTeX-inhibit-prefix-letter t)
(setq YaTeX-kanji-code nil)
(setq YaTeX-use-LaTeX2e t)
(setq YaTeX-use-AMS-LaTeX t)

;; ================================================================
;; RefTeX with YaTeX
;; ================================================================
(add-hook 'yatex-mode-hook 'turn-on-reftex)
(add-hook 'yatex-mode-hook
          '(lambda ()
             (reftex-mode 1)
             (define-key reftex-mode-map (concat YaTeX-prefix ">") 'YaTeX-comment-region)
             (define-key reftex-mode-map (concat YaTeX-prefix "<") 'YaTeX-uncomment-region)))

;; ================================================================
;; Outline minor mode for YaTeX
;; See http://www.math.s.chiba-u.ac.jp/~matsu/emacs/emacs20/outline.html
;; ================================================================
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

;; ================================================================
;; BibTeX
;; ================================================================
(add-hook 'bibtex-mode-hook
          '(lambda ()
             (outline-minor-mode)))

;; ================================================================
;; IPA Fonts
;; ================================================================
(setq YaTeX-dvipdf-command "dvipdfmx -f ptex-ipa")

;; ================================================================
;; auto-fill-mode
;; ================================================================
(add-hook 'yatex-mode-hook
          '(lambda ()
             (auto-fill-mode 1)))

;;; 40-yatex.el ends here
