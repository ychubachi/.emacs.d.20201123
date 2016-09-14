;;; F5でnotes.orgを開く
(defun my/open-notes-org()
   "note.orgを開きます．"
   (interactive)
   (find-file "~/Dropbox/Org/notes.org"))
(bind-key "<f5>" 'my/open-notes-org)

;;; F6でindex.orgを開く
(defun my/open-index-org()
   "index.orgを開きます．"
   (interactive)
   (find-file "~/git/www_chubachi_net/org/index.org"))
(bind-key "<f6>" 'my/open-index-org)
