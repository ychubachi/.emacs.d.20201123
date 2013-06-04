(require 'package)

;; package.elでelispを入れるdirectoryの設定
(setq package-user-dir "~/.emacs.d/packages/elpa/")
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/"))
;(add-to-list 'package-archives
;	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)

;; ここに使っているパッケージを書く。
(defvar installing-package-list
  '(
    auto-complete
    coffee-mode
    color-theme		                ; nice looking emacs
    color-theme-tango	                ; check out color-theme-solarized
    dropdown-list
    escreen            			; screen for emacs, C-\ C-h
    flymake-easy
    flymake-php
    flymake-ruby
    flymake-haml
    google-c-style
    haml-mode
    haskell-mode
    js2-mode
    magit
    markdown-mode
    migemo
    open-junk-file
    php-mode
    rbenv
    recentf-ext
    redo+
    ruby-block
    scala-mode
    scss-mode
    switch-window			; takes over C-x o
    yaml-mode
    yasnippet
    zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
    smex
    goto-last-change
    buffer-move
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
