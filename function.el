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

(defun my/open-inits-folder()
  "自分の設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/"))
(global-set-key (kbd "C-`") 'my/open-inits-folder)


