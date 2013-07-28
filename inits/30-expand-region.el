;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand-region
;; - リージョンを論理的に広げたり，狭めたりする
;;

;; パッケージのインストール
(setq package-list '(expand-region))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "M-=") 'er/contract-region)

