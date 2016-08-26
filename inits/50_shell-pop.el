;;; shell-pop
(use-package shell-pop
  :init
  (custom-set-variables
   '(shell-pop-autocd-to-working-dir nil)
   '(shell-pop-shell-type
     (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
   '(shell-pop-universal-key "C-z")
   '(shell-pop-window-height 30))
  :ensure t)
