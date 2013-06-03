;; auto-complete
(when (require 'auto-complete-config nil t)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (ac-config-default))
