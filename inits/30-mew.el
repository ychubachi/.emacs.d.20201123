;;; 30-mew.el --- mew
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(mew))
  (when (not (package-installed-p package))
    (package-install package)))

(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; ================================================================
;; Mewの設定
;; ================================================================

; Stunnel
(setq mew-prog-ssl "/usr/bin/stunnel4")

; IMAP for Gmail
(setq mew-proto "%")
(setq mew-imap-server "imap.gmail.com")
(setq mew-imap-user "yoshihide.chubachi@gmail.com")
(setq mew-imap-auth  t)
(setq mew-imap-ssl t)
(setq mew-imap-ssl-port "993")
(setq mew-smtp-auth t)
(setq mew-smtp-ssl t)
(setq mew-smtp-ssl-port "465")
(setq mew-smtp-user "yoshihide.chubachi@gmail.com")
(setq mew-smtp-server "smtp.gmail.com")
(setq mew-fcc "%[Gmail]/送信済みメール") ; 送信メイルを保存する
(setq mew-imap-trash-folder "%[Gmail]/すべてのメール")

(setq mew-use-cached-passwd t)
;(setq mew-use-master-passwd t)

(setq mew-ssl-verify-level 0)
;(setq mew-use-unread-mark t)

; w3m
(condition-case nil
    (require 'mew-w3m)
  (error (message "mew-w3m: Plase install w3m")))

; pdf viewer
(setq mew-prog-pdf '("evince" nil t))

;;; 30-mew.el ends here
