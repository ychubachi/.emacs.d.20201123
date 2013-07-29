;; パッケージのインストール
(setq package-list '(multiple-cursors region-bindings-mode))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; 複数のカーソルを扱う
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; リージョンがある間のキーバインディングを変更する
(require 'region-bindings-mode)
(region-bindings-mode-enable)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)


