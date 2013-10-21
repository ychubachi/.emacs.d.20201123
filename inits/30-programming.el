;;; 30-programming.el --- プログラミング用パッケージ
;;; Commentary:
;;;  auto-complete : 補間
;;; Code:

;; ================================================================
;; 自動補間
;; ================================================================

(prelude-require-package 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; ================================================================
;; 複数のカーソルを扱う
;; ================================================================

(prelude-require-package 'multiple-cursors)
(require 'multiple-cursors)

;; ================================================================
;; yasnippet
;; - http://fukuyama.co/yasnippet
;; ================================================================

(prelude-require-package 'yasnippet)
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

;; ================================================================
;; Emacs Lisp
;; ================================================================

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

;;; 30-programming.el ends here
