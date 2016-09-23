;;; mew の設定

;; stunnel の設定方法
;; - Emacs + Mew で Gmail を読み書きする - Jedipunkz's Blog - http://jedipunkz.github.io/blog/2013/08/12/emacs-mew-gmail/
;; Less secure apps
;; - Less secure apps - Account settings - https://www.google.com/settings/security/lesssecureapps

(use-package mew
  :commands (mew mew-send)
  :config
  ;; Optional setup (Read Mail menu):
  (setq read-mail-command 'mew)

  ;; Optional setup (e.g. C-xm for sending a message):
  (autoload 'mew-user-agent-compose "mew" nil t)
  (if (boundp 'mail-user-agent)
      (setq mail-user-agent 'mew-user-agent))
  (if (fboundp 'define-mail-user-agent)
      (define-mail-user-agent
	'mew-user-agent
	'mew-user-agent-compose
	'mew-draft-send-message
	'mew-draft-kill
	'mew-send-hook))

  ;; Stunnel
  (setq mew-prog-ssl "/usr/bin/stunnel4")
  ;; IMAP for Gmail
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
  (setq mew-imap-trash-folder "%[Gmail]/ゴミ箱")
  (setq mew-use-cached-passwd t)
  (setq mew-ssl-verify-level 0)
  ;; Personal settings
  (setq mew-from-list '("Yoshihide Chubachi <yc@aiit.ac.jp>"
			"Yoshihide Chubachi <yoshi@chubachi.net>"))
  )
