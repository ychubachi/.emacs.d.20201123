;; load paths
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "elisp" "git")

;; ;; Emacs
;; (setq inhibit-startup-screen t)
;; (tool-bar-mode 0)
;; (scroll-bar-mode 0)
;; (menu-bar-mode 0)
;; (setq frame-title-format
;;       (format "%%f - Emacs@%s" (system-name)))

;; (setq show-paren-delay 0)
;; (show-paren-mode t)
;; (setq show-paren-style 'expression)
;; (set-face-background 'show-paren-match-face nil)
;; (set-face-underline-p 'show-paren-match-face "green")

;; ;; key bindings
;; (keyboard-translate ?\C-h ?\C-?)
;; (global-set-key (kbd "C-x ?") 'help-command)

(require 'emacs-kicker)
