;;; shell-pop
(use-package shell-pop
  :bind ("C-z" . shell-pop)
  :config
  (custom-set-variables
   '(shell-pop-autocd-to-working-dir nil)
   '(shell-pop-shell-type
     (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
   '(shell-pop-window-height 30))
  :ensure t)
