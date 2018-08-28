;;; サーバの開始
(require 'server)

;; Suppress error "directory ~/.emacs.d/server is unsafe" on windows.
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))

(unless (server-running-p)
  (server-start))

;; バッファをキルするときに出る確認を抑制
(remove-hook
  'kill-buffer-query-functions
  'server-kill-buffer-query-function)

;; emacsclientでサーバに接続時，上の設定が無効になることの対処
(defun server-kill-buffer-query-function () t)

;;; packageシステムの初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
;; (package-refresh-contents)

;;; use-packageの導入

;; use-packageマクロを利用できるようにします。
;;  - [[https://github.com/jwiegley/use-package][jwiegley/use-package]]
;;  - [[https://github.com/emacsattic/bind-key][emacsattic/bind-key]]
;;     - you can use M-x describe-personal-keybindings to see all such bindings you've set throughout your Emacs.
;;   (describe-personal-keybindings)
;; - bind-key も利用できるようになります

(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; 日本語/UTF-8に
;; - 言語環境を日本語に，コード体系をUTF-8にします．
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;;; 無駄な行末の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; recentf - 最近使ったファイル
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 5 60) 'recentf-save-list)

;;; FFAP - その場所のファイルやURLを開く
(ffap-bindings)
