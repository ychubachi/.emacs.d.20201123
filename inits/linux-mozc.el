;;; mozc

;; emacs-mozcのインストール
;;   sudo apt install emacs-mozc

;; 注意: ~/.Xresourcesに
;;   Emacs24*useXIM:	false
;; と設定しておくこと。設定したら
;;   xrdb ~/.Xresources
;; を端末で実行する

(use-package mozc)
(setq default-input-method "japanese-mozc")

(use-package mozc-popup)
(setq mozc-candidate-style 'popup)

;; (global-set-key (kbd "C-o") 'toggle-input-method)

;; 日本語入力時のカーソル色の変更
(add-hook 'input-method-activate-hook
	  '(lambda () (set-cursor-color "green")))

(add-hook 'input-method-inactivate-hook
	  '(lambda () (set-cursor-color "orchid")))

;; 変換キーでon
(global-set-key [henkan]
		(lambda () (interactive)
		  (when (null current-input-method)
		    (toggle-input-method))))

;; 無変換キーでon
(global-set-key [muhenkan]
		(lambda () (interactive)
		  (inactivate-input-method)))

;; 全角半角キーと無変換キーのキーイベントを横取りする
(defadvice mozc-handle-event (around intercept-keys (event))
  "Intercept keys muhenkan and zenkaku-hankaku, before passing keys
to mozc-server (which the function mozc-handle-event does), to
properly disable mozc-mode."
  (if (member event (list 'zenkaku-hankaku 'muhenkan))
      (progn
	(mozc-clean-up-session)
	(toggle-input-method))
    (progn ;(message "%s" event) ;debug
      ad-do-it)))
(ad-activate 'mozc-handle-event)

;;; 参考

;; 変換/無変換キーで mozc.el を on/off する - ぴょぴょぴょ？ - Linuxとかプログラミングの覚え書き -
;; - http://d.hatena.ne.jp/pyopyopyo/20140108/p1
