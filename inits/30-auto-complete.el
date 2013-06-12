;; auto-complete
(when (require 'auto-complete-config nil t)
  (define-key ac-complete-mode-map "\C-n" 'ac-next)
  (define-key ac-complete-mode-map "\C-p" 'ac-previous)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
  (ac-config-default))
