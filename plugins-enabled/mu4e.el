
(require 'mu4e)
(require 'org-mu4e)

(setq mu4e-maildir       "~/Maildir")
(setq mu4e-sent-folder   "/[Gmail].All Mail")
(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-trash-folder  "/[Gmail].Trash")
(setq mu4e-refile-folder "/[Gmail].All Mail")

(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"             . ?i)
         ("/[Gmail].All Mail"  . ?a)
         ("/[Gmail].Drafts"    . ?d)
         ("/[Gmail].Trash"     . ?t)))

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;; (setq
;;    mu4e-get-mail-command "offlineimap"
;;    mu4e-update-interval 300)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; show images
(setq mu4e-show-images t)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(setq mu4e-msg2pdf "/usr/bin/msg2pdf")

(add-to-list 'mu4e-view-actions
             '("View in browser" . mu4e-action-view-in-browser) t)

;; convert org mode to HTML automatically
(setq org-mu4e-convert-to-html t)

(setq mu4e-html2text-command "w3m -dump -T text/html")

(add-to-list 'mu4e-bookmarks '("flag:flagged" "Flagged (Starred in Gmail)" ?s))

(defalias 'org-mail 'org-mu4e-compose-org-mode)

(setq mu4e-headers-date-format "%y-%m-%d %H:%M")
(setq mu4e-headers-time-format "%y-%m-%d %H:%M")

(setq mu4e-headers-fields
      '((:human-date . 14)
        (:flags . 6)
        (:from . 15)
        (:subject)))

(setq mu4e-headers-skip-duplicates 't)
