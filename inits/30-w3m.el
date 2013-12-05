;;; 30-w3m.el --- <description>
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(w3m))
  (when (not (package-installed-p package))
    (package-install package)))
;;; 30-w3m.el ends here
