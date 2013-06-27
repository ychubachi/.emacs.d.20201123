;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOT IN PACKAGE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.rbenv/versions/2.0.0-p195/lib/ruby/gems/2.0.0/gems/rcodetools-0.8.5.0")
(require 'rcodetools)
(define-key ruby-mode-map (kbd "<C-return>") 'rct-complete-symbol)

