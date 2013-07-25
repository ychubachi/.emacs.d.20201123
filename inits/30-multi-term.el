;; パッケージのインストール
(setq package-list '(multi-term))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;;
;; multi-term
;;
(add-hook 'term-mode-hook
	  '(lambda ()
	     ;; C-h を term 内文字削除にする
	     (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
	     ;; C-y を term 内ペーストにする
	     (define-key term-raw-map (kbd "C-y") 'term-paste)
	     ;; C-c p を M-pにする
	     (define-key term-raw-map (kbd "C-c C-p") 'term-send-up)
	     ;; C-c n を M-nにする
	     (define-key term-raw-map (kbd "C-c C-n") 'term-send-down)
	     ;; The default way to toggle between them is C-c C-j and C-c C-k, let's
	     ;; better use just one key to do the same.
	     (define-key term-raw-map  (kbd "C-'") 'term-line-mode)
	     (define-key term-mode-map (kbd "C-'") 'term-char-mode)
	     ;; Have C-y act as usual in term-mode, to avoid C-' C-y C-'
	     ;; Well the real default would be C-c C-j C-y C-c C-k.
	     (define-key term-raw-map  (kbd "C-y") 'term-paste)
	     ))

