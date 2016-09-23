;;; outline-minor-modeのキーバインディング

;; Emacs Lispの汎変数（とその他） - Qiita - http://qiita.com/kawabata@github/items/9a1a1e211c57a56578d8

(use-package outline
  :config
  (progn
    ;; C-c @ になっているプリフィックスを C-c C-o にします
    (setq outline-minor-mode-prefix "\C-c\C-o")
    ;; org-mode 風のキーバインディングを設定します
    (bind-key "<tab>" 'org-cycle
	      outline-minor-mode-map)
    (bind-key "<backtab>" 'org-global-cycle ; S-<tab> ?
 	      outline-minor-mode-map)
    (bind-key "C-c C-f" 'outline-forward-same-level
	      outline-minor-mode-map)
    (bind-key "C-c C-b" 'outline-backward-same-level
	      outline-minor-mode-map)
    (bind-key "C-c C-n" 'outline-next-visible-heading
	      outline-minor-mode-map)
    (bind-key "C-c C-p" 'outline-previous-visible-heading
	      outline-minor-mode-map)))

;;; outline-minor-modeを有効にするモードを設定
(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
