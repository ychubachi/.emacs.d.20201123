;;; mozc

;; .Xresource
;; emacs.useXIM:false

;; xrdb -merge ~/.Xresource

(require 'mozc-popup)
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'popup)
