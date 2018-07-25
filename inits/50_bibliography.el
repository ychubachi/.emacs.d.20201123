(use-package helm-bibtex
  :bind
  ("C-c b" . helm-bibtex)
  :config
  (setq bibtex-completion-bibliography
	"~/git/bibliography/references.bib"
	bibtex-completion-library-path
	"~/git/bibliography/bibtex-pdfs"
	bibtex-completion-notes-path
	"~/git/bibliography/helm-bibtex-notes")
  (setq bibtex-completion-pdf-open-function 'org-open-file))

(use-package org-ref
  :config
  (setq reftex-default-bibliography
	'("~/git/bibliography/references.bib"))
  (setq org-ref-bibliography-notes
	"~/git/bibliography/notes.org"
	org-ref-default-bibliography
	'("~/git/bibliography/references.bib")
	org-ref-pdf-directory
	"~/git/bibliography/bibtex-pdfs/"))

(use-package org
  :bind
  (:map org-mode-map
	("C-c r c" . org-ref-helm-insert-cite-link)
	("C-c r l" . org-ref-helm-insert-label-link)
	("C-c r r" . org-ref-helm-insert-ref-link)))

(use-package ebib
  :bind
  ("C-c e" . ebib)
  :config
  (progn
    (setq
     ebib-file-search-dirs '("~/git/bibliography/")
     ebib-preload-bib-files '("~/git/bibliography/references.bib"))))
