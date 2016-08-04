;;;; packageシステムを初期化します
(require 'package)
(setq package-archives '(
                        ("elpa" . "http://tromey.com/elpa/")
                        ("gnu" . "http://elpa.gnu.org/packages/")
                        ("marmalade" . "http://marmalade-repo.org/packages/")
                        ("melpa-stable" . "http://stable.melpa.org/packages/")))
(package-initialize)
(package-refresh-contents)

;;;; use-packageを導入します

;; use-packageマクロを利用できるようにします。
;;  - [[https://github.com/jwiegley/use-package][jwiegley/use-package]]
;;  - [[https://github.com/emacsattic/bind-key][emacsattic/bind-key]]
;;     - you can use M-x describe-personal-keybindings to see all such bindings you've set throughout your Emacs.
;;   (describe-personal-keybindings)
;; - bind-key も利用できるようになります

(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)
