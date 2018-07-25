;;; open-junk-file
(use-package open-junk-file
  :bind ("C-c j" . open-junk-file)
  :init
  (setq open-junk-file-directory "~/tmp/junk/%Y/%m/%d-%H%M%S.")
  :ensure t)

