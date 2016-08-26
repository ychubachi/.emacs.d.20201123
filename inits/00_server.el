;;;; サーバを開始します

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
