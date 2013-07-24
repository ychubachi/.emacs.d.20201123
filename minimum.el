;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 日本語の設定
;;
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;; (set-default-coding-systems 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-next-selection-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; key bindings
;;

;; C-hをBSにする
(global-set-key "\C-h" 'delete-backward-char)

;; C-c C-hをhelpにする
(global-set-key (kbd "C-c C-h") 'help-command)

;; C-zでshellを起動する
(global-set-key (kbd "C-z") 'shell)

