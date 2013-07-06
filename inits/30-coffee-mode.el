;; パッケージのインストール
(setq package-list '(coffee-mode flymake-coffee))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;;
;; coffeescript
;;
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(setq whitespace-action
      '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style
      '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
(defun coffee-custom ()
  "coffee-mode-hook"
  ;; CoffeeScript uses two spaces.
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-custom)

;;
(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)