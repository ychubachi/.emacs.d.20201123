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
(setq mew-fcc "%Sent") ; 送信メイルを保存する
(setq mew-imap-trash-folder "%[Gmail]/すべてのメール")
(setq mew-use-cached-passwd t)

(setq mew-ssl-verify-level 0)
(setq mew-use-unread-mark t)
