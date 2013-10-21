;;; 30-documentation.el --- 文書作成用
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(smartrep graphviz-dot-mode))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; markdownモードでアウトラインを有効にする
;; ================================================================
(add-hook 'markdown-mode-hook
          '(lambda () (outline-minor-mode t)))

;; ================================================================
;; orgモード
;; ================================================================

;; (dolist (package '(org))
;;   (when (not (package-installed-p package))
;;     (package-install package)))

;; ;; org-default-notes-fileのディレクトリ
;; (setq org-directory "~/Dropbox/Note")			; orgディレクトリ
;; (setq org-agenda-files `("~/Dropbox/Note/main.org"))    ; orgファイル
;; (setq org-mobile-inbox-for-pull "~/Dropbox/Note/flagged.org")
;; (setq org-mobile-directory "~/Dropbox/Note/MobileOrg")       ; MobileOrg用ディレクトリ

;; ;; ;; org-default-notes-fileのファイル名
;; ;; (setq org-default-notes-file "notes.org")

;; ;; TODO状態
;; (setq org-todo-keywords
;;       '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

;; (setq org-todo-keywords '((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|"
;;                                 "DONE(d)" "CANCELLED(c)" "DEFERRED(f)")))
;; (setq org-tag-alist '(("ANY" . ?a) ("HOME" . ?h) ("WORK" . ?w) ("OUTGO" . ?o)))

;; ;; DONEの時刻を記録
;; (setq org-log-done 'time)

;; ================================================================
;; 連続操作を素敵にするsmartrep.el作った - sheephead
;; http://sheephead.homelinux.org/2011/12/19/6930/
;; ================================================================

(require 'smartrep)
(eval-after-load "org"
  '(progn
     (smartrep-define-key
      org-mode-map "C-c" '(("C-n" . (lambda ()
                                      (outline-next-visible-heading 1)))
                           ("C-p" . (lambda ()
                                      (outline-previous-visible-heading 1)))))))

;; ================================================================
;; graphviz-dot-mode
;; ================================================================
(add-to-list 'auto-mode-alist '("\\.dot$" . graphviz-dot-mode))

;;; 30-documentation.el ends here
