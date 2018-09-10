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
