;;; org-ref
;; jkitchin/org-ref: org-mode modules for citations, cross-references, bibliographies in org-mode and useful bibtex tools to go with it. - https://github.com/jkitchin/org-ref

(use-package org-ref
  :config
  (setq reftex-default-bibliography
	'("~/Dropbox/Bibliography/references.bib"))

  ;; see org-ref for use of these variables
  (setq org-ref-bibliography-notes
	"~/Dropbox/Bibliography/notes.org"
	org-ref-default-bibliography
	'("~/Dropbox/Bibliography/references.bib")
	org-ref-pdf-directory
	"~/Dropbox/Bibliography/bibtex-pdfs/")
)
