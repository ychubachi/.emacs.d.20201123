;; init.el --- Emacsの初期設定
(load "server")
(unless (server-running-p)
      (server-start))
(define-key key-translation-map [?\C-h] [?\C-?])
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
(use-package org
             :bind
             (("C-c l" . org-store-link)
              ("C-c c" . org-capture)
              ("C-c a" . org-agenda)
              ("C-c b" . org-switchb))
             :init
             (progn
               (setq org-capture-templates
                     (quote
                      (("t" "Todo" entry (file+headline "todo.org" "Tasks")
                        "* TODO %?
               ")
                       ("l" "Link as Todo" entry (file+headline "todo.org" "Tasks")
                        "* TODO %?
               Link: %a
               Text: %i
               ")
                       ("j" "Journal" entry (file+datetree "journal.org")
                        "* %?
               ")
                       ("b" "Bookmark" entry (file+headline "bookmark.org" "Bookmarks")
                        "* %a :bookmark:
               引用: %i
               %?
               ")
                       )))
               (setq org-todo-keywords
                     (quote
                      ((sequence
                        "TODO(t)"
                        "WIP(p)"
                        "WAIT(w)"
                        "|"
                        "DONE(d)"
                        "SOMEDAY(s)"
                        "CANCEL(c)"))))
               (setq org-babel-load-languages
                     (quote
                      ((emacs-lisp . t)
                       (dot . t)
                       (java . t)
                       (ruby . t)
                       (sh . t))))
               (setq org-babel-sh-command "bash")
               (setq org-deadline-warning-days 7)
               (define-key org-mode-map "\M-q" 'toggle-truncate-lines)
               (setq org-agenda-custom-commands
                     (quote
                      (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
                       ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
                       ("p" "私用" tags-todo "+私用" nil)
                       ("P" "私用以外" tags-todo "-私用" nil)
                       ("n" "Agenda and all TODO's" ((agenda "" nil)
                                                     (alltodo "" nil)) nil))))
               (setq org-confirm-babel-evaluate nil)
               (setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
               (setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")
               (custom-set-faces
                '(org-column-title
                      ((t (:background "grey30" :underline t :weight bold :height 135)))))
               (custom-set-variables
                '(org-export-in-background nil)
                '(org-src-fontify-natively t)))
             :ensure t)
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)
        (load custom-file))
;;; init.el ends here
