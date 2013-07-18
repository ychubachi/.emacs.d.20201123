;;
;; idoはC-x C-fなどで候補のリストを出してくれるモードです．
;; C-s/C-rで次や前を選択できます（これをC-p/C-nにしたかった．）

;; パッケージのインストール
(setq package-list '(smex))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; use ido for minibuffer completion
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
; (define-key ido-mode-map (kbd "C-p") 'ido-prev-match) うまくいかない
; (define-key ido-mode-map (kbd "C-n") 'ido-next-match)

;; default key to switch buffer is C-x b, but that's not easy enough
;;
;; when you do that, to kill emacs either close its frame from the window
;; manager or do M-x kill-emacs.  Don't need a nice shortcut for a once a
;; week (or day) action.
(global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
;; (global-set-key (kbd "C-x C-c") 'ido-switch-buffer)
(global-set-key (kbd "C-x B") 'ibuffer)

;;
;; smex : idoをM-xでも使えるようにする
;;
(require 'smex)
(setq smex-save-file "~/.emacs.d/.smex-items")
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
