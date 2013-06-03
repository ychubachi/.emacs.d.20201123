
;; mozc
;; see http://mimikakimemo.hatenablog.jp/entry/2012/06/07/033710
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  
  ;; すぐ下に変換候補を表示
  (setq mozc-candidate-style 'overlay)
  ;;(setq mozc-candidate-style 'echo-area) ; デフォルトだとこっち（エコーエリアに表示）
  
  ;; 変換キーでon、無変換キーでoffで切り替え
  (global-set-key
   [henkan]
   (lambda () (interactive)
     (when (null current-input-method) (toggle-input-method))))
  (global-set-key
   [muhenkan]
   (lambda () (interactive)
     (inactivate-input-method)))
  (defadvice mozc-handle-event (around intercept-keys (event))
    "Intercept keys muhenkan and zenkaku-hankaku, before passing keys to mozc-server (which the function mozc-handle-event does), to properly disable mozc-mode."
  (if (member event (list 'zenkaku-hankaku 'muhenkan))
      (progn (mozc-clean-up-session)
             (toggle-input-method))
    (progn ;(message "%s" event) ;debug
      ad-do-it)))
  (ad-activate 'mozc-handle-event))
