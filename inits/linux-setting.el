;;; linux-setting.el --- My settings for Emacs in Linux
;;; Commentary:

;; 注意: in ~/.Xresourcesに
;;   Emacs*useXIM:	false
;; と設定しておくこと．
;;
;; Thanks: http://www11.atwiki.jp/s-irie/pages/21.html#basic
;; Thanks: http://d.hatena.ne.jp/iRiE/20100530/1275212234

;;; Change Log: Created on 2013-07-30
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(migemo))
  (when (not (package-installed-p package))
    (package-install package)))

;; ;; ================================================================
;; ;; Settings for mozc
;; ;; ================================================================

(require 'mozc)
(setq default-input-method "japanese-mozc")
(global-set-key (kbd "C-o") 'toggle-input-method)
(setq mozc-candidate-style 'overlay)

;; ================================================================
;; Font設定
;; ================================================================
;;
;; mmm あいうえお｜｜｜｜｜
;; iii ｜｜｜｜｜｜｜｜｜｜

(set-default-font "Ricty:pixelsize=16:spacing=0")

;; ================================================================
;; dbus for YaTeX
;; ================================================================
;;
;; http://oku.edu.mie-u.ac.jp/~okumura/texwiki/?Emacs#v19f2543

(require 'dbus)

(defun un-urlify (fname-or-url)
  "A trivial function that replaces a prefix of file:/// with just /."
  (if (string= (substring fname-or-url 0 8) "file:///")
      (substring fname-or-url 7)
    fname-or-url))

(defun evince-inverse-search (file linecol &rest ignored)
  (let* ((fname (un-urlify file))
         (buf (find-file fname))
         (line (car linecol))
         (col (cadr linecol)))
    (if (null buf)
        (message "[Synctex]: %s is not opened..." fname)
      (switch-to-buffer buf)
      (goto-line (car linecol))
      (unless (= col -1)
        (move-to-column col)))))

(when (boundp 'dbus-message-type-method-call) nil t
      (dbus-register-signal
       :session nil "/org/gnome/evince/Window/0"
       "org.gnome.evince.Window" "SyncSource"
       'evince-inverse-search))

;;; linux-setting.el ends here
