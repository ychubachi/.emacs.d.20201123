;;; F11でWikiを開く
(defun my/open-wiki-home()
   "設定フォルダを開きます．"
   (interactive)
   (find-file "~/Dropbox/Org/Wiki/home.org"))
(bind-key "<f12>" 'my/open-wiki-home)
