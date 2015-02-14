;; init.el --- Emacsの初期設定
(require 'package)
(add-to-list 'package-archives
                 '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
                 '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(package-refresh-contents)
(unless (package-installed-p 'use-package)
      (package-install 'use-package))
(require 'use-package)
(load "server")
(unless (server-running-p)
      (server-start))
(define-key key-translation-map [?\C-h] [?\C-?])
(require 'wdired)
(bind-key "r" 'wdired-change-to-wdired-mode dired-mode-map)
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)
(when (eq system-type 'gnu/linux)
      (add-to-list 'default-frame-alist '(font . "ricty-13.5")))
(use-package exec-path-from-shell
                 :config
                 (progn (exec-path-from-shell-initialize))
                 :ensure t)
(use-package shell-pop
             :config
             (custom-set-variables
              '(shell-pop-autocd-to-working-dir nil)
              '(shell-pop-shell-type
                (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
              '(shell-pop-universal-key "C-z")
              '(shell-pop-window-height 30))
             :ensure t)
(use-package undo-tree
             :config
             (global-undo-tree-mode t)
             :ensure t)
(use-package yasnippet
             :config
             (yas-global-mode 1)
             :ensure t)
(use-package magit
             :bind ("C-c g" . magit-status)
             :ensure t)
(use-package open-junk-file
             :bind ("C-c j" . open-junk-file)
             :config
             (setq open-junk-file-directory "~/tmp/junk/%Y/%m/%d-%H%M%S.")
             :ensure t)
(use-package paredit
             :init
             (add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
             (add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
             (add-hook 'lisp-mode-hook 'enable-paredit-mode)
             (add-hook 'ielm-mode-hook 'enable-paredit-mode)
             :ensure t)
(use-package lispxmp
             :init
             (bind-key "C-c e" 'lispxmp emacs-lisp-mode-map)
             :ensure t)
(use-package multiple-cursors
             :ensure t)
(use-package region-bindings-mode
             :init
             (progn
               (region-bindings-mode-enable)
               (bind-keys :map region-bindings-mode-map
                       ("a" . mc/mark-all-like-this)
                       ("p" . mc/mark-previous-like-this)
                       ("n" . mc/mark-next-like-this)
                       ("m" . mc/mark-more-like-this-extended)
                       ("e" . mc/edit-lines)))
             :ensure t)
(defun my/org-caputure-templates ()
  (setq org-capture-templates
        (quote
         (("t" "Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO %?
")
          ("l" "Link as Todo" entry (file+headline "todo.org" "Tasks")
           "* TODO %?
Link: %a
Text: %i
")
          ("j" "Journal" entry (file+datetree "journal.org")
           "* %?
")
          ("b" "Bookmark" entry (file+headline "bookmark.org" "Bookmarks")
           "* %a :bookmark:
引用: %i
%?
")
          ))))
(defun my/ox-latex ()
  (require 'ox-latex)
  (setq org-latex-default-class "bxjsarticle")
  (setq org-latex-pdf-process '("latexmk -e '$pdflatex=q/xelatex %S/' -e '$bibtex=q/bibtexu %B/' -e '$biber=q/biber --bblencoding=utf8 -u -U --output_safechars %B/' -e '$makeindex=q/makeindex -o %D %S/' -norc -gg -pdf %f"))
  (setq org-export-in-background t)

  (add-to-list 'org-latex-classes
               '("bxjsarticle"
                 "\\documentclass{bxjsarticle}
[NO-DEFAULT-PACKAGES]
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\usepackage{xltxtra}
\\usepackage{amsmath}
\\usepackage{newtxtext,newtxmath}
\\usepackage{graphicx}
\\usepackage{hyperref}
\\ifdefined\\kanjiskip
  \\usepackage{pxjahyper}
  \\hypersetup{colorlinks=true}
\\else
  \\ifdefined\\XeTeXversion
    \\hypersetup{colorlinks=true}
  \\else
    \\ifdefined\\directlua
      \\hypersetup{pdfencoding=auto,colorlinks=true}
    \\else
      \\hypersetup{unicode,colorlinks=true}
    \\fi
  \\fi
\\fi"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))
(defun my/ox-beamer ()
  (require 'ox-beamer)
  (add-to-list 'org-latex-classes
               '("beamer"
                 "\\documentclass[t]{beamer}
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\setbeamertemplate{navigation symbols}{}
\\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
\\AtBeginSection[]
{
  \\begin{frame}<beamer>{Outline}
  \\tableofcontents[currentsection,currentsubsection]
  \\end{frame}
}
\\setbeamertemplate{navigation symbols}{}"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
  (add-to-list 'org-latex-classes
               '("beamer_lecture"
                 "\\documentclass[t]{beamer}
[NO-DEFAULT-PACKAGES]
\\usepackage{zxjatype}
\\usepackage[ipa]{zxjafont}
\\setbeamertemplate{navigation symbols}{}
\\hypersetup{colorlinks,linkcolor=,urlcolor=gray}
\\AtBeginPart
{
\\begin{frame}<beamer|handout>
\\date{\\insertpart}
\\maketitle
\\end{frame}
}
\\AtBeginSection[]
{
\\begin{frame}<beamer>
\\tableofcontents[currentsection,currentsubsection]
\\end{frame}
}"
                   ("\\part{%s}" . "\\part*{%s}")
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))
(use-package org
             :bind
             (("C-c l" . org-store-link)
              ("C-c c" . org-capture)
              ("C-c a" . org-agenda)
              ("C-c b" . org-switchb))
             :init
             (progn
               (my/org-caputure-templates)
               (setq org-todo-keywords
                     (quote
                      ((sequence
                        "TODO(t)"
                        "WIP(p)"
                        "WAIT(w)"
                        "|"
                        "DONE(d)"
                        "SOMEDAY(s)"
                        "CANCEL(c)"))))
               (setq org-babel-load-languages
                     (quote
                      ((emacs-lisp . t)
                       (dot . t)
                       (java . t)
                       (ruby . t)
                       (sh . t))))
               (setq org-babel-sh-command "bash")
               (setq org-deadline-warning-days 7)
               (setq org-agenda-custom-commands
                     (quote
                      (("x" "TODOs without Scheduled" tags-todo "+SCHEDULED=\"\"" nil)
                       ("d" "TODOs without Deadline" tags-todo "+DEADLINE=\"\"" nil)
                       ("p" "私用" tags-todo "+私用" nil)
                       ("P" "私用以外" tags-todo "-私用" nil)
                       ("n" "Agenda and all TODO's" ((agenda "" nil)
                                                     (alltodo "" nil)) nil))))
               (setq org-confirm-babel-evaluate nil)
               (setq org-mobile-directory "~/Dropbox/アプリ/MobileOrg")
               (setq org-mobile-inbox-for-pull "~/Dropbox/Org/from-mobile.org")
               (custom-set-faces
                '(org-column-title
                      ((t (:background "grey30" :underline t :weight bold :height 135)))))
               (custom-set-variables
                '(org-export-in-background nil)
                '(org-src-fontify-natively t))
               (require 'ox-md) 
               (my/ox-latex)
               (my/ox-beamer)
               (add-to-list 'org-latex-packages-alist '("" "minted"))
               (setq org-latex-listings 'minted)
               (use-package ox-reveal :ensure t))
             :config
             (progn
               (bind-key "M-q" 'toggle-truncate-lines org-mode-map))
             :ensure t)
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p custom-file)
        (load custom-file))
;;; init.el ends here
