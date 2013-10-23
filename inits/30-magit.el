;;; 30-magit.el --- magit
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(magit))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'magit)
;;; 30-magit.el ends here
