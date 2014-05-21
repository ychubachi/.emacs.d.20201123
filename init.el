;; init.el --- Emacsの初期設定

(message "%s" "%% Emacsの設定を開始します %%")

(add-hook 'after-init-hook
          (lambda ()
            (setq custom-file "~/.emacs.d/custom.el")
            (if (file-exists-p (expand-file-name custom-file))
                (load (expand-file-name custom-file)))
            (message "%s" "%% custom.elを読み込みました %%")))

(load "server")
(unless (server-running-p)
  (server-start))

(let ((default-directory "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(setq auto-save-file-name-transforms
      (quote ((".*" "~/.emacs.d/data/backup/" t))))
(setq backup-directory-alist
      (quote (("\\.*$" . "~/.emacs.d/data/backup"))))

(setq bookmark-default-file
      "~/.emacs.d/data/bookmarks")

(global-auto-revert-mode 1)

(setq inhibit-startup-screen t)

(setq auto-save-list-file-prefix
      "~/data/auto-save-list/.saves-")

(show-paren-mode 1)

(add-hook 'before-save-hook
 'whitespace-cleanup)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(column-number-mode t)

(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)
(display-time-mode 1)

(custom-set-faces
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal)))))

(setq mouse-yank-at-point t)

(setq mouse-drag-copy-region t)

(setq compilation-ask-about-save nil)

(setq outline-minor-mode-prefix "")

(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(show-paren-mode 1)

(find-function-setup-keys)

(require 'package)
(setq package-archives
      '(("org" .       "http://orgmode.org/elpa/")
        ("gnu" .       "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" .     "http://melpa.milkbox.net/packages/")))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defun my/package-install (package-symbol)
  (unless (package-installed-p package-symbol)
    (package-install package-symbol)))

(defun my/package-install-and-require (package-symbol)
  (my/package-install package-symbol)
  (require package-symbol))

(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

(add-hook 'input-method-activate-hook
          '(lambda () (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
          '(lambda () (set-cursor-color "orchid")))

(when (eq system-type 'gnu/linux)
  (require 'mozc)
  (setq default-input-method "japanese-mozc")
  (global-set-key (kbd "C-o") 'toggle-input-method)
  (setq mozc-candidate-style 'overlay))

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)

;バッファのフォントサイズを大きく
(global-set-key (kbd "<prior>") 'text-scale-increase)
;バッファのフォントサイズを小さく
(global-set-key (kbd "<next>")  'text-scale-decrease)

(defun my/fullscreen ()
  (interactive)
  (set-frame-parameter
   nil
   'fullscreen
   (if (frame-parameter nil 'fullscreen)
       nil
     'fullboth)))

(defun my/open-init-folder()
  "設定フォルダを開きます．"
  (interactive)
  (find-file "~/.emacs.d/init.org"))

(global-set-key [f11] 'my/fullscreen)
(global-set-key (kbd "<f1>") 'my/open-init-folder)

(defun my/other-window-backward ()
  "Move to other window backward."
  (interactive)
  (other-window -1))

(define-prefix-command 'personal-map)
(global-set-key (kbd "C-.") 'personal-map)

(define-key 'personal-map (kbd "C-n") 'other-window)
(define-key 'personal-map (kbd "C-p") 'my/other-window-backward)

(define-key 'personal-map (kbd "m") 'imenu)
(define-key 'personal-map (kbd "h") 'helm-mini)

(define-key 'personal-map (kbd "i") 'yas-insert-snippet)
(define-key 'personal-map (kbd "n") 'yas-new-snippet)
(define-key 'personal-map (kbd "v") 'yas-visit-snippet-file)

(define-key 'personal-map (kbd "y") 'helm-c-yas-complete)
(define-key 'personal-map (kbd "s") 'helm-c-yas-create-snippet-on-region)

(define-key 'personal-map (kbd "b") 'org-beamer-export-to-pdf)

(cond ((eq system-type 'gnu/linux)
       (define-key 'personal-map (kbd "p") 'evince-forward-search))
      ((eq system-type 'darwin)
       (define-key 'personal-map (kbd "p") 'skim-forward-search)))

(setq dot-file-dir (file-name-directory
                     (or (buffer-file-name) load-file-name)))
(setq org-file-dir (expand-file-name "plugins-enabled" dot-file-dir))
(mapc #'org-babel-load-file (directory-files org-file-dir t "\\.org$"))

(message "%s" "%% init.elは完了しました %%")

;;; init.el ends here
