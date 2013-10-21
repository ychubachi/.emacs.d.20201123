;;; 30-programming.el --- プログラミング用パッケージ
;;; Commentary:
;;;  auto-complete : 補間
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(auto-complete multiple-cursors yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; 自動補間
;; ================================================================

(require 'auto-complete-config)
(ac-config-default)
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; ================================================================
;; 複数のカーソルを扱う
;; ================================================================

(require 'multiple-cursors)

;; ================================================================
;; yasnippet
;; - http://fukuyama.co/yasnippet
;; ================================================================

(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

;; ================================================================
;; Emacs Lisp
;; ================================================================

(add-hook 'emacs-lisp-mode-hook 'outline-minor-mode)

;;; 30-programming.el ends here
