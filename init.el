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

;; ibus-mode
;; http://d.hatena.ne.jp/supermassiveblackhole/20100609/1276059762
(require 'ibus)
; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
; Change cursor color depending on IBus status
(setq ibus-cursor-color '("limegreen" "white" "blue"))
(global-set-key "\C-\\" 'ibus-toggle)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Options (Run M-x customize-option to change them)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
