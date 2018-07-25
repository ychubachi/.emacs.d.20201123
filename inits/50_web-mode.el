;;; web-mode
(use-package web-mode
  :mode (("\\.html?\\'" . web-mode)
         ("\\.erb?\\'"  . web-mode)
         ("\\.css?\\'"  . web-mode)
         ("\\.scss?\\'" . web-mode)
         ("\\.js?\\'"   . web-mode))
  :config
  (progn
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset	2)
    (setq web-mode-code-indent-offset	2)))
