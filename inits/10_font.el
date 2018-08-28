;;; デフォルトフォントの設定

;; ↓のテーブルが揃っていればOK
;;  |あぱ　ああ|
;;  |+-+-+-+-+-|
;;  |imimimimim|

;; ｰ Fontに関する調査
;;   - [[file:test.org::*Emacs%E3%81%AE%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88%E3%81%AE%E3%81%8A%E8%A9%B1][Emacsのフォントのお話]]
;;   - この値はcustomize可能です．

(cond
 ((eq system-type 'gnu/linux)
  (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
 ((eq system-type 'darwin)
  (add-to-list 'default-frame-alist '(font . "ricty-14")))
 ((eq system-type 'windows-nt)
  (add-to-list 'default-frame-alist '(font . "Ricty Diminished"))))
