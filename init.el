;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Author:	Y.Chubachi （中鉢 欣秀）
;; Created:	2013-06-04
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; My minimum settings
(load "~/.emacs.d/minimum.el")

;; My minimum settings
(load "~/.emacs.d/function.el")

;; Setup for packages
(load "~/.emacs.d/package.el")

;; Load a lot of packages
(load "~/.emacs.d/load.el")

;; Custom file
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom.el"))
    (load (expand-file-name custom-file) t nil nil))
