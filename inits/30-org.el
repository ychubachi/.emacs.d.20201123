;; orgはビルトインのため，一回手動でインストールしないとだめなのかも．

;; パッケージのインストール
(setq package-list '(org))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

; キーバインドの設定
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cr" 'org-remember)
;; 拡張子がorgのファイルを開いた時，自動的にorg-modeにする
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; org-modeでの強調表示を可能にする
(add-hook 'org-mode-hook 'turn-on-font-lock)
;; 見出しの余分な*を消す
(setq org-hide-leading-stars t)

;; org-default-notes-fileのディレクトリ
(setq org-directory "~/Dropbox/Note")			; orgディレクトリ
(setq org-agenda-files `("~/Dropbox/Note/main.org"))    ; orgファイル
(setq org-mobile-inbox-for-pull "~/Dropbox/Note/flagged.org")
(setq org-mobile-directory "~/Dropbox/Note/MobileOrg")       ; MobileOrg用ディレクトリ

;; ;; org-default-notes-fileのファイル名
;; (setq org-default-notes-file "notes.org")

;; TODO状態
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "|" "DONE(d)" "SOMEDAY(s)")))

(setq org-todo-keywords '((type "TODO(t)" "STARTED(s)" "WAITING(w)" "APPT(a)" "|"
				"DONE(d)" "CANCELLED(c)" "DEFERRED(f)")))
(setq org-tag-alist '(("ANY" . ?a) ("HOME" . ?h) ("WORK" . ?w) ("OUTGO" . ?o)))

;; DONEの時刻を記録
(setq org-log-done 'time)
