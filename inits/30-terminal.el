;;; 30-terminal.el --- 端末用設定
;;; Commentary:
;;; Code:

;; ================================================================
;; shell-pop
;; - 詳細設定はM-x customize-group RET sholl-pop RET
;; ================================================================

(prelude-require-package 'shell-pop)
(require 'shell-pop)
(define-key global-map (kbd "C-z") 'shell-pop)

;;; 30-terminal.el ends here
