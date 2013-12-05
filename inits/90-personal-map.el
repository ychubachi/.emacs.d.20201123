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
;; キーバインディング
;; ================================================================

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)

;; ================================================================
;; 自作関数
;; ================================================================

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
  (dired "~/.emacs.d/inits"))

(defun my/open-note()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/index.org"))
  
(defun my/open-todo()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Todo/todo.txt"))

(defun my/open-project-folder()
  "プロジェクトフォルダを開きます．"
  (interactive)
  (dired "~/git/"))

(global-set-key [f11] 'my/fullscreen)
(global-set-key (kbd "<f1>") 'my/open-init-folder)
(global-set-key (kbd "<f2>") 'my/open-note)
(global-set-key (kbd "<f3>") 'my/open-todo)
(global-set-key (kbd "<f4>") 'my/open-project-folder)

;; ================================================================
;; グローバルマップの設定
;; ================================================================

;;; shell-pop
(global-set-key (kbd "C-z") 'shell-pop)

;;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ================================================================
;; グローバルマップの設定(org-mode)
;; ================================================================
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)

;; ================================================================
;; グローバルマップの設定(helm)
;; ================================================================
(let ((key-and-func
       `(
         (,(kbd "M-x")     helm-M-x)
         (,(kbd "M-y")     helm-show-kill-ring)
         (,(kbd "C-x C-f") helm-find-files)
;;         (,(kbd "C-r")   helm-for-files)
;;         (,(kbd "C-^")   helm-c-apropos)
;;         (,(kbd "C-;")   helm-resume)
;;         (,(kbd "M-s")   helm-occur)
;;         (,(kbd "M-z")   helm-do-grep)
;;         (,(kbd "C-S-h") helm-descbinds)
         )))
  (loop for (key func) in key-and-func
        do (global-set-key key func)))

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
(setq region-bindings-mode-disabled-modes '(mew-summary-mode))

;; ================================================================
;; key-chordの設定をする
;; ================================================================
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "gc" 'my/other-window-backward)
(key-chord-define-global "cr" 'other-window)

;;; 90-personal-map.el ends here
