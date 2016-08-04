;;; lispxmp - lisp式の評価結果を注釈する

;;   - M-; M-; で lispxmp用コメントの自動挿入
;;   - C-c e で評価結果を注釈

(use-package lispxmp
  :init
  (bind-key "C-c e" 'lispxmp emacs-lisp-mode-map)
  :ensure t)
