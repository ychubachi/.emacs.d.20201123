(require 'cl)

;; ここに使っているパッケージを書く。
(defvar installing-package-list
  '(
    auto-complete
    coffee-mode
    color-theme		                ; nice looking emacs
;    color-theme-tango	                ; check out color-theme-solarized
    dropdown-list
    escreen            			; screen for emacs, C-\ C-h
    flymake-easy
    flymake-php
    flymake-ruby
    flymake-haml
    flymake-sass
    google-c-style
    haml-mode
    haskell-mode
    js2-mode
    magit
    magithub
    markdown-mode
    migemo
    open-junk-file
    php-mode
    rbenv
    recentf-ext
    redo+
    ruby-block
    ruby-electric
    scala-mode
    scss-mode
    switch-window			; takes over C-x o
    yaml-mode
    yasnippet
    zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
    smex
    goto-last-change
    buffer-move
    mew
    multi-term
    shell-pop
    w3m
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
