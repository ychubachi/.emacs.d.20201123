
(my/package-install 'auto-complete)
(require 'auto-complete-config)
(eval-after-load "auto-complete-config"
  '(progn
     (message "%s" "%% auto-complete-configを読み込みました. %%")
     (ac-config-default)
     (setq ac-comphist-file "~/.emacs.d/data/ac-comphist.dat")
     (define-key ac-complete-mode-map "\C-n" 'ac-next)
     (define-key ac-complete-mode-map "\C-p" 'ac-previous)))
