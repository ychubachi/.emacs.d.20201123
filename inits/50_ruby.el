;;; Ruby開発

;;; HAML
(use-package haml-mode
  :mode ("\\.haml?\\'" . haml-mode)
  :config
  (progn
    (use-package flymake-haml)
    (add-hook 'haml-mode-hook 'flymake-haml-load)))


;;; flymake

;;   (require 'flymake-ruby)
;;  (add-hook 'ruby-mode-hook 'flymake-ruby-load)
;;


;;   (require 'flymake-sass)
;;   (add-hook 'sass-mode-hook 'flymake-sass-load)

;;   (require 'flymake-coffee)
;;   (add-hook 'coffee-mode-hook 'flymake-coffee-load)
