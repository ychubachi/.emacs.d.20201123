;;; region-bindings-mode

;; リージョンがある間のキーバインディングを変更する
(use-package region-bindings-mode
  :init
  (progn
    (region-bindings-mode-enable)
    (bind-keys :map region-bindings-mode-map
	       ("a" . mc/mark-all-like-this)
	       ("p" . mc/mark-previous-like-this)
	       ("n" . mc/mark-next-like-this)
	       ("m" . mc/mark-more-like-this-extended)
	       ("e" . mc/edit-lines)))
  :ensure t)
