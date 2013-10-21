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

;; ================================================================
;; Settings for IBUS
;; ================================================================

(require 'ibus)

;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)

;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)

;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)

;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("green" "red" "blue"))

;; Set the window position
(setq ibus-prediction-window-position t)

;; Toggle input status
(global-set-key (kbd "C-o") 'ibus-toggle)
;; (define-key 'personal-map (kbd "C-o") 'ibus-toggle)

;; Use henkan key to enable IBus
(global-set-key [henkan] 'ibus-enable)
(define-key 'personal-map (kbd "C-e") 'ibus-enable)

;; Use muhenkan key to disable IBus
(global-set-key [muhenkan] 'ibus-disable)
(define-key 'personal-map (kbd "C-d") 'ibus-disable)

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

;; ================================================================
;; ローマ字で日本語をインクリメンタルサーチ
;; ================================================================
;;
;; # 注意
;; * cmigemoコマンドがインストールされていること．
;; * locate migemo-dictで辞書の場所調べ，設定してください．
;; # 参考
;; * https://github.com/emacs-jp/migemo

(require 'migemo)

(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)

(load-library "migemo")
(migemo-init)

;;; linux-setting.el ends here
