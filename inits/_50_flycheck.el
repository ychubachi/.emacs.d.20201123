;;; 50_flycheck.el --- Summary

;; Flycheck

;;; Commentary:

;; For ruby:
;;   $ gem install rubocop ruby-lint

;;; Code:
(use-package flycheck
  :init
  (global-flycheck-mode))

(provide '50_flycheck)
;;; 50_flycheck.el ends here
