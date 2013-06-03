;; for ruby
; (require 'ruby-end)
(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (abbrev-mode 1)
	     (electric-pair-mode t)
	     (electric-indent-mode t)
	     (electric-layout-mode t)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (add-to-list 'ruby-encoding-map '(undecided . utf-8))))
