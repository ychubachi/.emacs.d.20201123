;;; notes.orgを開く
(defun my/open-notes-org()
   "note.orgを開きます．"
   (interactive)
   (find-file "~/Dropbox/Org/notes.org"))
(bind-key "<f5>" 'my/open-notes-org)

;;; index.orgを開く
(defun my/open-index-org()
   "index.orgを開きます．"
   (interactive)
   (find-file "~/git/www_chubachi_net/org/index.org"))
(bind-key "<f6>" 'my/open-index-org)

;;; refferences.bibを開く
(defun my/open-refferences-bib()
   "refferences.bibを開きます．"
   (interactive)
   (find-file "~/git/bibliography/references.bib"))
(bind-key "<f7>" 'my/open-refferences-bib)
