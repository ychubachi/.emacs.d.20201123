;;; 30-magit.el --- magit
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(magit))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; Key bindings
;; ================================================================
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;;; 30-magit.el ends here
