(setq file-name-coding-system 'cp932)

;; Ctrl-gとかでベルを鳴らさないようにします。
(setq visible-bell t)
(setq ring-bell-function 'ignore)

;;;** 標準IMEの設定
(setq default-input-method "W32-IME")

;;;** IMEの初期化
(w32-ime-initialize)

;;;** IME状態のモードライン表示
(setq-default w32-ime-mode-line-state-indicator "[--]")
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))

;;;** IME OFF時の初期カーソルカラー
(set-cursor-color "red")

;;;** IME ON/OFF時のカーソルカラー
(add-hook 'input-method-activate-hook
          (lambda() (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
          (lambda() (set-cursor-color "red")))

;;;** バッファ切り替え時にIME状態を引き継ぐ
(setq w32-ime-buffer-switch-p nil)

;;;** Ctrl-Oでトグルするようにする
(global-set-key (kbd "C-o") 'toggle-input-method)

;; ;; cp932エンコード時の表示を「P」とする
;; (coding-system-put 'cp932 :mnemonic ?P)
;; (coding-system-put 'cp932-dos :mnemonic ?P)
;; (coding-system-put 'cp932-unix :mnemonic ?P)
;; (coding-system-put 'cp932-mac :mnemonic ?P)
