;;; サーバの開始

;; - Emacs serverの開始
;; - Emacs 既に起動している場合は立ち上げない
;;   - [[http://stackoverflow.com/questions/5570451/how-to-start-emacs-server-only-if-it-is-not-started][configuration - How to start emacs server only if it is not started? - Stack Overflow]]

;; WindowsでEmacsにテキストファイルを関連付けする - 技術memo - http://nenono.hatenablog.com/entry/2015/01/05/155225

(require 'server)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))
  ; Suppress error "directory ~/.emacs.d/server is unsafe" on windows.
(unless (server-running-p)
  (server-start))
(remove-hook
  'kill-buffer-query-functions
  'server-kill-buffer-query-function)

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

;;; C-hをDELと交換

;; (global-set-key (kbd "C-h") 'delete-backward-char) はものたりない
;; なぜかは忘れた

;; - C-h が押されたら，C-? (<DEL>) に変換する．
;; - ヘルプは[F1]でも参照できる．
;; - 参考
;; 	 - [[http://akisute3.hatenablog.com/entry/20120318/1332059326][EmacsのC-hをbackspaceとして使用する - 勉強日記]]
;; 	 - [[http://www.gnu.org/software/emacs/manual/html_node/efaq/Swapping-keys.html#Swapping-keys][Swapping keys - GNU Emacs FAQ]]
;; - keyboad-translate関数はサーバにする際動作しなかった
;; 	 - [[http://lists.gnu.org/archive/html/help-gnu-emacs/2009-10/msg00505.html][Re: keyboard-translate not working with emacs daemon]]

(define-key key-translation-map [?\C-h] [?\C-?])

;;;; C-c ? を help-for-help にします
(bind-key "C-c ?" 'help-for-help)

;;; 日本語/UTF-8に
;; - 言語環境を日本語に，コード体系をUTF-8にします．
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;;; デフォルトフォントの設定

;; ↓のテーブルが揃っていればOK
;;  |あぱ　ああ|
;;  |+-+-+-+-+-|
;;  |imimimimim|

;; ｰ Fontに関する調査
;;   - [[file:test.org::*Emacs%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%81%8A%E8%A9%B1][Emacsのフォントのお話]]
;;   - この値はcustomize可能です．

(cond
 ((eq system-type 'gnu/linux)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
 ((eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(font . "ricty-14"))))

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
