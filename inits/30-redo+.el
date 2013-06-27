;; redo+
;; パッケージのインストール
(setq package-list '(redo+))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'redo+)
(global-set-key (kbd "C-,") 'redo)

;; ついでにundoも設定
(global-set-key (kbd "C-.") 'undo)
