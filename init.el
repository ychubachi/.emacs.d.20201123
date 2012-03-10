;; Load path
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; shell 
(global-set-key (kbd "C-z") 'shell)
(ansi-color-for-comint-mode-on) ; color (for Shell) 要らないかな?

;; Magit
(require 'magit)
(global-set-key (kbd "M-v") 'magit-status)

;; haml
(setq auto-mode-alist
      (cons (cons "\\.haml$" 'haml-mode) auto-mode-alist))
(autoload 'haml-mode "haml-mode.el" "haml-mode" t)
(add-hook 'haml-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;; scss
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; japanese-anthy をデフォルトの input-method にする。
(load-library "anthy")
(setq default-input-method "japanese-anthy")
(setq anthy-wide-space " ")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Options (Run M-x customize-option to change them)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
