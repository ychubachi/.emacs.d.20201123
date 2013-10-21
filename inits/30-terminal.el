;;; 30-terminal.el --- 端末用設定
;;; Commentary:
;;; Code:


;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(shell-pop))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; shell-pop
;; - 詳細設定はM-x customize-group RET sholl-pop RET
;; ================================================================

(require 'shell-pop)
(define-key global-map (kbd "C-z") 'shell-pop)

;;; 30-terminal.el ends here
