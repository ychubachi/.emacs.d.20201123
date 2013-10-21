;;; cocoa-emacs-setting.el --- Mac用設定
;;; Commentary:
;;; Code:

;; ================================================================
;; Keyboard settings
;; ================================================================

;; option <-> meta
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;;システムへ修飾キーを渡さない
(setq mac-pass-control-to-system nil)
(setq mac-pass-command-to-system nil)
(setq mac-pass-option-to-system nil)

;;; C-oで日本語切り替え
(mac-input-method-mode t)
(global-set-key "\C-o" 'toggle-input-method)

;; かな
(mac-set-input-method-parameter
 "com.google.inputmethod.Japanese.base" 'cursor-color 'green)

;; 英数字
(mac-set-input-method-parameter
 "com.google.inputmethod.Japanese.Roman" 'cursor-color 'red)

;; change cursor type
(mac-set-input-method-parameter
 "com.google.inputmethod.Japanese.base" 'cursor-type 'box)

;; ================================================================
;; Fonts
;; ================================================================

;; |あああああ|
;; |+-+-+-+-+-|
;; |imimimimim|

(when (x-list-fonts "Ricty")
  (let* ((size 14)
         (asciifont "Ricty")
         (jpfont "Ricty")
         (h (* size 10))
         (fontspec)
         (jp-fontspec))
    (set-face-attribute 'default nil :family asciifont :height h)
    (setq fontspec (font-spec :family asciifont))
    (setq jp-fontspec (font-spec :family jpfont))
    (set-fontset-font nil 'japanese-jisx0208 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0212 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-1 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
    (set-fontset-font nil '(#x0080 . #x024F) fontspec)
    (set-fontset-font nil '(#x0370 . #x03FF) fontspec)))

;;; cocoa-emacs-setting.el ends here
