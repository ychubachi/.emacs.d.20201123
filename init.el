;; init.el --- Emacsの初期設定

(load "server")
(unless (server-running-p)
  (server-start))

(define-key key-translation-map [?\C-h] [?\C-?])

(add-hook 'before-save-hook
 'whitespace-cleanup)

(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

(when (eq system-type 'gnu/linux)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(package-refresh-contents)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(use-package ace-jump-mode
             :bind (("C-." . ace-jump-mode)
                    ("C-," . ace-jump-line-mode))
             :ensure t)

(use-package exec-path-from-shell
             :config
             (progn (exec-path-from-shell-initialize))
             :ensure t)

(use-package shell-pop
             :config
             (custom-set-variables
              '(shell-pop-autocd-to-working-dir nil)
              '(shell-pop-shell-type
                (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
              '(shell-pop-universal-key "C-z")
              '(shell-pop-window-height 30))
             :ensure t)

(use-package undo-tree
             :config
             (global-undo-tree-mode t)
             :ensure t)

(use-package yasnippet
             :config
             (yas-global-mode 1)
             :ensure t)

(use-package magit
             :bind ("C-c g" . magit-status)
             :ensure t)

(use-package open-junk-file
             :bind ("C-c j" . open-junk-file)
             :config
             (setq open-junk-file-directory "~/tmp/junk/%Y/%m/%d-%H%M%S.")
             :ensure t)

(use-package multiple-cursors
             :ensure t)

(use-package region-bindings-mode
             :init
             (progn
               (region-bindings-mode-enable)
               (define-key region-bindings-mode-map
                 "a" 'mc/mark-all-like-this)
               (define-key region-bindings-mode-map
                 "p" 'mc/mark-previous-like-this)
               (define-key region-bindings-mode-map
                 "n" 'mc/mark-next-like-this)
               (define-key region-bindings-mode-map
                 "m" 'mc/mark-more-like-this-extended)
               (define-key region-bindings-mode-map
                 "e" 'mc/edit-lines))
             :ensure t)

(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)
    (load custom-file))

;;; init.el ends here
