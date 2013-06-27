;; パッケージのインストール
(setq package-list '(buffer-move))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

; buffer-move : have to add your own keys
(global-set-key (kbd "<C-S-up>")     'buf-move-up)
(global-set-key (kbd "<C-S-down>")   'buf-move-down)
(global-set-key (kbd "<C-S-left>")   'buf-move-left)
(global-set-key (kbd "<C-S-right>")  'buf-move-right)
