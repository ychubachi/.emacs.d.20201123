;; non-package install

(autoload 'wikipedia-mode "wikipedia-mode.el"
  "Major mode for editing documents in Wikipedia markup." t)

(add-to-list 'auto-mode-alist
	     '("\\.wiki\\'" . wikipedia-mode))


 (add-to-list 'auto-mode-alist
   '("www\\.chubachi\\.net" . wikipedia-mode))
