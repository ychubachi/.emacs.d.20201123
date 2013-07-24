;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Author:	Y.Chubachi （中鉢 欣秀）
;; Created:	2013-06-04
;;
;; Thanks: http://qiita.com/items/5f1cd86e2522fd3384a0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; My minimum settings
(load "~/.emacs.d/minimum.el")

;; Setup for packages
(load "~/.emacs.d/package.el")

;; Load a lot of packages
(load "~/.emacs.d/load.el")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(shell-pop-shell-type (quote ("multi-term" "*terminal<1>*" (quote (lambda nil (multi-term))))))
 '(shell-pop-universal-key "C-z"))
