; wdiredを用い，diredから直接ファイルをリネームできるようにします．
(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)