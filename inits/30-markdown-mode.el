;; パッケージのインストール
(setq package-list '(markdown-mode))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md$" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook
          '(lambda () (outline-minor-mode t)))
