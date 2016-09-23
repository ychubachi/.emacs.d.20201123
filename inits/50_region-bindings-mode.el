;;; リージョンがある間のキーバインディングを変更する
(use-package multiple-cursors)

(use-package region-bindings-mode
  :config
  (progn
    (bind-keys :map region-bindings-mode-map
	       ("a" . mc/mark-all-like-this)
	       ("p" . mc/mark-previous-like-this)
	       ("n" . mc/mark-next-like-this)
	       ("m" . mc/mark-more-like-this-extended)
	       ("e" . mc/edit-lines)
	       ("r" . align-regexp)
	       ("i" . indent-region))
    (region-bindings-mode-enable)))
