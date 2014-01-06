;;; 30-w3m.el --- <description>
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(w3m))
  (when (not (package-installed-p package))
    (condition-case nil
	(package-install package)
      (error (message "Please Install w3m")))))
;;; 30-w3m.el ends here
