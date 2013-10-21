;;; 90-personal-map.el --- 個人用キーマップ
;;; Commentary:
;;
;; http://www.emacswiki.org/emacs/PrefixKey
;;
;;; Code:

;; ================================================================
;; 自作マクロ
;; ================================================================

(defun my/other-window-backward ()
  "Move to other window backward."
  (interactive)
  (other-window -1))

;; ================================================================
;; 個人用キーマップを設定する
;; ================================================================

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

(cond ((eq system-type 'gnu/linux)
       (define-key 'personal-map (kbd "p") 'evince-forward-search))
      ((eq system-type 'darwin)
       (define-key 'personal-map (kbd "p") 'skim-forward-search)))

;; ================================================================
;; リージョンがある間のキーバインディングを変更する
;; ================================================================

(prelude-require-package 'region-bindings-mode)
(require 'region-bindings-mode)
(region-bindings-mode-enable)
(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)
(define-key region-bindings-mode-map "e" 'mc/edit-lines)

;; ================================================================
;; key-chordの設定をする
;; ================================================================
(key-chord-define-global "gc"     'my/other-window-backward)
(key-chord-define-global "cr"     'other-window)

;;; 90-personal-map.el ends here
