;;; ace-jump-mode
(use-package ace-jump-mode
  :bind (("C-c ." . ace-jump-mode)
	 ("C-c ," . ace-jump-line-mode))
  :ensure t)
