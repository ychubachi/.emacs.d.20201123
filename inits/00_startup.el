;;; packageシステムの初期化
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;;; use-packageの導入

;; use-packageマクロを利用できるようにします。
;;  - [[https://github.com/jwiegley/use-package][jwiegley/use-package]]
;;  - [[https://github.com/emacsattic/bind-key][emacsattic/bind-key]]
;;     - you can use M-x describe-personal-keybindings to see all such bindings you've set throughout your Emacs.
;;   (describe-personal-keybindings)
;; - bind-key も利用できるようになります

(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;;; 無駄な行末の空白を削除
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; recentf - 最近使ったファイル
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 5 60) 'recentf-save-list)

;;; FFAP - その場所のファイルやURLを開く
(ffap-bindings)
