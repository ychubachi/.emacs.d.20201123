;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; tabbar.el
;;
;; [Emacsにタブ機能を追加するtabbar.elの導入 - 12FF5B8](http://hico-horiuchi.hateblo.jp/entry/20121208/1354975316)

;; パッケージのインストール
(setq package-list '(tabbar))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'tabbar)
(tabbar-mode)
(global-set-key "\M-]" 'tabbar-forward)  ; 次のタブ
(global-set-key "\M-[" 'tabbar-backward) ; 前のタブ
;; タブ上でマウスホイールを使わない
(tabbar-mwheel-mode nil)
;; グループを使わない
(setq tabbar-buffer-groups-function nil)
;; 左側のボタンを消す
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))
