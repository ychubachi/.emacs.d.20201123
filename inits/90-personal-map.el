;;; 90-personal-map.el --- 個人用キーマップ
;;; Commentary:
;;
;; http://www.emacswiki.org/emacs/PrefixKey
;;
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(region-bindings-mode key-chord))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; グローバルマップの設定
;; ================================================================
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

(global-set-key (kbd "C-z") 'shell-pop)

;; ================================================================
;; 個人用キーマップの設定
;; ================================================================
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

(cond ((eq system-type 'gnu/linux)
       (define-key 'personal-map (kbd "p") 'evince-forward-search))
      ((eq system-type 'darwin)
       (define-key 'personal-map (kbd "p") 'skim-forward-search)))

;; undo-tree
(define-key 'personal-map (kbd "u") 'undo-tree-undo)
(define-key 'personal-map (kbd "r") 'undo-tree-redo)

;; ================================================================
;; リージョンがある間のキーバインディングを変更する
;; ================================================================

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
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "gc"     'my/other-window-backward)
(key-chord-define-global "cr"     'other-window)

;;; 90-personal-map.el ends here
