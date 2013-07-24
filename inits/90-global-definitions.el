;; Global definitions for Emacs

;; full screen
(defun fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'fullscreen)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 自作関数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my-open-inits-folder()        ; 対話的版
  "自分の設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/inits"))
(global-set-key (kbd "C-`") 'my-open-inits-folder)


