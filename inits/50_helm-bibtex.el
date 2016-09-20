(use-package helm-bibtex
  :config
  (setq bibtex-completion-bibliography
	"~/Dropbox/Bibliography/references.bib"
	bibtex-completion-library-path
	"~/Dropbox/Bibliography/bibtex-pdfs"
	bibtex-completion-notes-path
	"~/Dropbox/Bibliography/helm-bibtex-notes")

  ;; alternative
  (setq bibtex-completion-pdf-open-function 'org-open-file))
