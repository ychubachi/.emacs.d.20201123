;;; F12でWikiを開く
(defun my/open-wiki-home()
   "Wikiフォルダを開きます．"
   (interactive)
   (find-file "~/Dropbox/Org/Wiki/home.org"))
(bind-key "<f12>" 'my/open-wiki-home)
