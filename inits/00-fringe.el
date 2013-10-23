;;; 00-fringe.el --- へり（画面と画面の間の領域）
;;; Commentary:
;;; Code:

;; バッファ中の行番号表示
(global-linum-mode t)

;; 行番号のフォーマット
(set-face-attribute 'linum nil :foreground "yellow" :height 0.8)
(setq linum-format "%4d")

;;; 00-fringe.el ends here
