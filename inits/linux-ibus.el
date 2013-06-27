;; Settings for IBUS
::
;; 注意: in ~/.Xresourcesに
;;   Emacs*useXIM:	false
;; と設定しておくこと．
;;
;; Thanks: http://www11.atwiki.jp/s-irie/pages/21.html#basic
;; Thanks: http://d.hatena.ne.jp/iRiE/20100530/1275212234
;;

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
(setq ibus-cursor-color '("red" "blue" "limegreen"))
;; Set the window position
(setq ibus-prediction-window-position t)

;; Use henkan key to enable IBus
(global-set-key [henkan] 'ibus-enable)
;; Use muhenkan key to disable IBus
(global-set-key [muhenkan] 'ibus-disable)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
