;;; 30-terminal.el --- 端末用設定
;;; Commentary:

;; shell-pop
;; - 詳細設定はM-x customize-group RET sholl-pop RET

;;; Code:

(dolist (package '(shell-pop))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'shell-pop)
;;; 30-terminal.el ends here
