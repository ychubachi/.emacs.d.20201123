;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 自作関数
;;

;; full screen
(defun my/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'my/fullscreen)

(defun my/open-init-folder()
  "設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/"))
(global-set-key (kbd "<f1>") 'my/open-init-folder)

(defun my/open-note()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/index.org"))
(global-set-key (kbd "<f2>") 'my/open-note)
  
(defun my/open-todo()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Todo/todo.txt"))
(global-set-key (kbd "<f3>") 'my/open-todo)

(defun my/open-project-folder()
  "プロジェクトフォルダを開きます．"
  (interactive)
  (dired "~/git/"))
(global-set-key (kbd "<f4>") 'my/open-project-folder)




