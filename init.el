;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(scss-compile-at-save t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load path
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory  "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Global Set Key
(global-set-key (kbd "C-z") 'shell)

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

;; Color (for Shell)
(ansi-color-for-comint-mode-on)

;; Uniquify
(require 'uniquify)

;; Evernote
(require 'evernote-mode)
(setq evernote-enml-formatter-command '("w3m" "-dump" "-I" "UTF8" "-O" "UTF8"))
(global-set-key "\C-cec" 'evernote-create-note)
     (global-set-key "\C-ceo" 'evernote-open-note)
     (global-set-key "\C-ces" 'evernote-search-notes)
     (global-set-key "\C-ceS" 'evernote-do-saved-search)
     (global-set-key "\C-cew" 'evernote-write-note)
     (global-set-key "\C-cep" 'evernote-post-region)
     (global-set-key "\C-ceb" 'evernote-browser)

;; japanese-anthy をデフォルトの input-method にする。
(set-language-environment "Japanese")
(load-library "anthy")
(setq default-input-method "japanese-anthy")
