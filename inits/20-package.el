(require 'package)

;; package.elでelispを入れるdirectoryの設定
(setq package-user-dir "~/.emacs.d/packages/elpa/")

(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'cl)

;; ここに使っているパッケージを書く。
(defvar installing-package-list
  '(
    auto-complete
    coffee-mode
    dropdown-list
    flymake-easy
    flymake-php
    flymake-ruby
    google-c-style
    haml-mode
    haskell-mode
    js2-mode
    markdown-mode
    migemo
    open-junk-file
    php-mode
    rbenv
    recentf-ext
    ruby-block
    scala-mode
    scss-mode
    yaml-mode
    yasnippet
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
