;;; 30-undo-tree.el --- undo-tree
;;; Commentary:
;;; Code:

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(undo-tree))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'undo-tree)
(global-undo-tree-mode t)
;;; 30-undo-tree.el ends here
