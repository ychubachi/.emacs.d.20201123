;;; wdired でリネームできるようにします

;; diredモードで r キーを押すと編集モードに入る．
;; 完了したらC-c C-cで決定．C-c ESCでキャンセル．

;; wdiredのrequireはdired-mode-mapを定義するために必要． -> ??

(use-package wdired
  :init
  (bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map))
