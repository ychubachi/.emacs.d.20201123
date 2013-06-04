;;
;; Author: Y.Chubachi
;; Created: 2013-06-04
;;
;; Thanks: http://qiita.com/items/5f1cd86e2522fd3384a0
;;

;; load paths
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))
(add-to-load-path "site-lisp" "git")

(require 'init-loader)
;(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; on to the visual settings

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 100))



;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

;; Navigate windows with M-<arrows>
(windmove-default-keybindings 'meta)
(setq windmove-wrap-around t)

; winner-mode provides C-<left> to get back to previous window layout
(winner-mode 1)

;; whenever an external process changes a file underneath emacs, and there
;; was no unsaved changes in the corresponding buffer, just revert its
;; content to reflect what's on-disk.
(global-auto-revert-mode 1)



;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; (global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;; C-x C-j opens dired with the cursor right on the file you're editing
(require 'dired-x)

;; ;; under mac, have Command as Meta and keep Option for localized input
;; (when (string-match "apple-darwin" system-configuration)
;;   (setq mac-allow-anti-aliasing t)
;;   (setq mac-command-modifier 'meta)
;;   (setq mac-option-modifier 'none))

;; (unless (string-match "apple-darwin" system-configuration)
;;   ;; on mac, there's always a menu bar drown, don't have it empty
;;   (menu-bar-mode -1))

;; ;; choose your own fonts, in a system dependant way
;; (if (string-match "apple-darwin" system-configuration)
;;     (set-face-font 'default "Monaco-13")
;;   (set-face-font 'default "Monospace-10"))

;; ;; Magit
;; (require 'magit)
;; (global-set-key (kbd "M-v") 'magit-status)

;; ;; flymake
;; (require 'flymake)
;; (global-set-key [f3] 'flymake-display-err-menu-for-current-line)
;; (global-set-key [f4] 'flymake-goto-next-error)

;; ;; flymake-haml
;; (require 'flymake-haml)
;; (add-hook 'haml-mode-hook 'flymake-haml-load)

;; ;; set local recipes
;; (setq
;;  el-get-sources
;;  '((:name buffer-move			; have to add your own keys
;; 	  :after (progn
;; 		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
;; 		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
;; 		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
;; 		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

;;    (:name smex				; a better (ido like) M-x
;; 	  :after (progn
;; 		   (setq smex-save-file "~/.emacs.d/.smex-items")
;; 		   (global-set-key (kbd "M-x") 'smex)
;; 		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

;;    ;; (:name magit				; git meet emacs, and a binding
;;    ;; 	  :after (lambda ()
;;    ;; 		   (global-set-key (kbd "C-x C-z") 'magit-status)))

;;    (:name goto-last-change		; move pointer back to last change
;; 	  :after (progn
;; 		   ;; when using AZERTY keyboard, consider C-x C-_
;; 		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; ;; now set our own packages
;; (setq
;;  my:el-get-packages
;;  '(el-get				; el-get is self-hosting
;;    ibus
;;    ))

;; ;;
;; ;; Some recipes require extra tools to be installed
;; ;;
;; ;; Note: el-get-install requires git, so we know we have at least that.
;; ;;
;; (when (el-get-executable-find "cvs")
;;   (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

;; (when (el-get-executable-find "svn")
;;   (loop for p in '(psvn    		; M-x svn-status
;; 		   yasnippet		; powerful snippet mode
;; 		   )
;; 	do (add-to-list 'my:el-get-packages p)))

;; (setq my:el-get-packages
;;       (append
;;        my:el-get-packages
;;        (loop for src in el-get-sources collect (el-get-source-name src))))

;; ;; install new packages and init already installed packages
;; (el-get 'sync my:el-get-packages)


