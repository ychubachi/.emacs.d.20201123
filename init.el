
(require 'org-protocol)

(setq org-publish-project-alist
          '(
        ("chubachi.net-notes"
         :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
         :base-extension "org"
         :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
         :publishing-function org-html-publish-to-html
         ;; :headline-levels 3
         ;; :section-numbers nil
         ;; :with-toc nil
         ;; :html-head "<link rel=\"stylesheet\"
         ;;               href=\"../other/mystyle.css\" type=\"text/css\"/>"
         ;; :html-preamble t
         :recursive t
         )
        ("chubachi.net-static"
         :base-directory "~/Ubuntu One/WebSites/chubachi.net/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Ubuntu One/WebSites/chubachi.net/www/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("chubachi.net"
         :components ("chubachi.net-notes" "chubachi.net-static"))
          ))

(require 'org-page)

(require 'org2blog-autoloads)

(setq org2blog/wp-use-sourcecode-shortcode t)

(eval-after-load "org"
      '(progn
         (smartrep-define-key
         org-mode-map
         "C-c" '(("C-n" . (lambda ()
                                (outline-next-visible-heading 1)))
                 ("C-p" . (lambda ()
                                (outline-previous-visible-heading 1)))))
         ))

(require 'ox-reveal)

(let (custom-file-system-name)
      (setq custom-file-system-name
        (format "~/.emacs.d/custom/%s.el" (system-name)))
      (when (file-exists-p custom-file-system-name)
        (message "%s" (format "%sを読み込みます" custom-file-system-name))
        (load custom-file)))

(when (eq system-type 'gnu/linux)
      (require 'mozc)
      (setq default-input-method "japanese-mozc")
      (setq mozc-candidate-style 'overlay))

(add-hook 'after-init-hook
          (lambda ()
        (message "%s" "%% custom.elを読み込みました %%")))

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(let ((default-directory "~/.emacs.d/git/"))
      (normal-top-level-add-subdirs-to-load-path))

(let ((default-directory "~/.emacs.d/site-lisp/"))
      (normal-top-level-add-subdirs-to-load-path))

(require 'smartrep)

(require 'paredit)
(add-hook 'emacs-lisp-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'lisp-mode-hook 'enable-paredit-mode)
(add-hook 'ielm-mode-hook 'enable-paredit-mode)

(add-hook 'outline-minor-mode-hook
              (lambda () (local-set-key "\C-c\C-o"
                                        outline-mode-prefix-map)))

(require 'lispxmp)
(define-key emacs-lisp-mode-map (kbd "C-c e") 'lispxmp)

(add-hook 'markdown-mode-hook
              '(lambda () (outline-minor-mode t)))

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
        (yas-minor-mode . " Ys")
        (paredit-mode . " Pe")
        (eldoc-mode . "")
        (abbrev-mode . "")
        (undo-tree-mode . " Ut")
        (elisp-slime-nav-mode . " EN")
        (helm-gtags-mode . " HG")
        (flymake-mode . " Fm")
        (outline-minor-mode . " Ol")
        (ibus-mode . " IB")
        ;; Major modes
        (lisp-interaction-mode . "Li")
        (python-mode . "Py")
        (ruby-mode   . "Rb")
        (emacs-lisp-mode . "El")
        (markdown-mode . "Md")))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
                (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
                (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

;; (require 'tex-site)
(require 'tex-jp)

(eval-after-load "tex-jp"
      '(progn
         (setq TeX-engine-alist '((pdfuptex "pdfupTeX"
                                        "ptex2pdf -u -e -ot '%S %(mode)'"
                                        "ptex2pdf -u -l -ot '%S %(mode)'"
                                        "euptex")))
         (setq japanese-TeX-engine-default 'pdfuptex)
         (setq TeX-view-program-selection '((output-dvi "Evince")
                                        (output-pdf "Evince")))
         (setq japanese-LaTeX-default-style "jsarticle")
         (dolist (command '("pTeX" "pLaTeX" "pBibTeX" "jTeX" "jLaTeX" "jBibTeX" "Mendex"))
       (delq (assoc command TeX-command-list) TeX-command-list))))
(setq preview-image-type 'dvipng)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)
(add-hook 'LaTeX-mode-hook 'TeX-source-correlate-mode)
(add-hook 'LaTeX-mode-hook 'TeX-PDF-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook
              (function (lambda ()
                      (add-to-list 'TeX-command-list
                                       '("Latexmk"
                                         "latexmk %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-pdfupLaTeX"
                                         "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/mendex %%O -U -o %%D %%S/' -e '$dvipdf=q/dvipdfmx %%O -o %%D %%S/' -norc -gg -pdfdvi %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-pdfupLaTeX2"
                                         "latexmk -e '$latex=q/uplatex %%O %S %(mode) %%S/' -e '$bibtex=q/upbibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/mendex %%O -U -o %%D %%S/' -e '$dvips=q/dvips %%O -z -f %%S | convbkmk -u > %%D/' -e '$ps2pdf=q/ps2pdf %%O %%S %%D/' -norc -gg -pdfps %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfupLaTeX2"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-pdfLaTeX"
                                         "latexmk -e '$pdflatex=q/pdflatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtex %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-pdfLaTeX"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-LuaLaTeX"
                                         "latexmk -e '$pdflatex=q/lualatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaLaTeX"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-LuaJITLaTeX"
                                         "latexmk -e '$pdflatex=q/luajitlatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-LuaJITLaTeX"))
                      (add-to-list 'TeX-command-list
                                       '("Latexmk-XeLaTeX"
                                         "latexmk -e '$pdflatex=q/xelatex %%O %S %(mode) %%S/' -e '$bibtex=q/bibtexu %%O %%B/' -e '$biber=q/biber %%O --bblencoding=utf8 -u -U --output_safechars %%B/' -e '$makeindex=q/makeindex %%O -o %%D %%S/' -norc -gg -pdf %t"
                                         TeX-run-TeX nil (latex-mode) :help "Run Latexmk-XeLaTeX"))
                      (add-to-list 'TeX-command-list
                                       '("xdg-open"
                                         "xdg-open %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run xdg-open"))
                      (add-to-list 'TeX-command-list
                                       '("Evince"
                                         "evince %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run Evince"))
                      (add-to-list 'TeX-command-list
                                       '("fwdevince"
                                         "fwdevince %s.pdf %n \"%b\""
                                         TeX-run-discard-or-function t t :help "Forward search with Evince"))
                      (add-to-list 'TeX-command-list
                                       '("Okular"
                                         "okular --unique \"file:\"%s.pdf\"#src:%n %a\""
                                         TeX-run-discard-or-function t t :help "Forward search with Okular"))
                      (add-to-list 'TeX-command-list
                                       '("zathura"
                                         "zathura -s -x \"emacsclient --no-wait +%%{line} %%{input}\" %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run zathura"))
                      (add-to-list 'TeX-command-list
                                       '("fwdzathura"
                                         "zathura --synctex-forward %n:0:%b %s.pdf"
                                         TeX-run-discard-or-function t t :help "Forward search with zathura"))
                      (add-to-list 'TeX-command-list
                                       '("qpdfview"
                                         "qpdfview --unique \"\"%s.pdf\"#src:%b:%n:0\""
                                         TeX-run-discard-or-function t t :help "Forward search with qpdfview"))
                      (add-to-list 'TeX-command-list
                                       '("TeXworks"
                                         "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texworks --position=%%{page+1} %%{output}\""
                                         TeX-run-discard-or-function t t :help "Run TeXworks"))
                      (add-to-list 'TeX-command-list
                                       '("TeXstudio"
                                         "synctex view -i \"%n:0:%b\" -o %s.pdf -x \"texstudio --pdf-viewer-only --page %%{page+1} %%{output}\""
                                         TeX-run-discard-or-function t t :help "Run TeXstudio"))
                      (add-to-list 'TeX-command-list
                                       '("MuPDF"
                                         "mupdf %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run MuPDF"))
                      (add-to-list 'TeX-command-list
                                       '("Firefox"
                                         "firefox -new-window %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run Mozilla Firefox"))
                      (add-to-list 'TeX-command-list
                                       '("Chromium"
                                         "chromium --new-window %s.pdf"
                                         TeX-run-discard-or-function t t :help "Run Chromium")))))

;;
;; RefTeX with AUCTeX
;;
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;;
;; kinsoku.el
;;
(setq kinsoku-limit 10)

(add-hook 'LaTeX-mode-hook 'outline-minnor-mode)

(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

(setq graphviz-dot-preview-extension "pdf")

(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-c h") 'helm-mini)

(setq helm-delete-minibuffer-contents-from-point t)

(dolist (package '(helm-descbinds
                   helm-migemo
                   helm-themes
                   imenu-anywhere
                   helm-c-yasnippet))
  (when (not (package-installed-p package))
        (package-install package)))

(require 'helm-command)
(require 'helm-descbinds)

(setq helm-idle-delay             0.1
          helm-input-idle-delay       0.1
          helm-candidate-number-limit 200)

(when (executable-find "cmigemo")
      (require 'helm-migemo)
      (setq helm-use-migemo t)

      (defadvice helm-c-apropos
        (around ad-helm-apropos activate)
        "候補が表示されないときがあるので migemoらないように設定."
        (let ((helm-use-migemo nil))
      ad-do-it))

      (defadvice helm-M-x
        (around ad-helm-M-x activate)
        "候補が表示されないときがあるので migemoらないように設定."
        (let ((helm-use-migemo nil))
      ad-do-it))
      )

(require 'helm-imenu)
(setq imenu-auto-rescan t)
(setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

(require 'helm-themes)

(require 'helm-c-yasnippet)

(require 'helm-package)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'helm-recentf)

(unless (executable-find "cmigemo")
      (warn "！！ 警告：cmigemoコマンドが呼び出せません　！！"))

(when (and (executable-find "cmigemo")
               (require 'migemo nil t))
      (setq migemo-options '("-q" "--emacs"))

      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)
      (setq migemo-coding-system 'utf-8-unix)
      (load-library "migemo")
      (migemo-init)

      (setq migemo-command "cmigemo")

      (cond
       ((eq system-type 'gnu/linux)
        (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
       ((eq system-type 'darwin)
        (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")))
      )

(autoload 'ruby-mode "ruby-mode"
      "Mode for editing ruby source files" t)
(require 'ruby-mode)

;; ================================================================
;; Ruby DSLs
;; ================================================================

(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))

;; ================================================================
;; outline-minnor-mode
;; ================================================================

(require 'outline)
(add-hook 'ruby-mode-hook
              (function
               (lambda ()
                 (defun ruby-outline-level ()
               (or (and (match-string 1)
                        (or (cdr (assoc (match-string 1) outline-heading-alist))
                                (- (match-end 1) (match-beginning 1))))
                       (cdr (assoc (match-string 0) outline-heading-alist))
                       (- (match-end 0) (match-beginning 0))))

                 (set (make-local-variable 'outline-level) 'ruby-outline-level)

                 (set (make-local-variable 'outline-regexp)
                      (rx (group (* " "))
                      bow
                      (or "begin" "case" "class" "def" "else" "elsif"
                              "ensure" "if" "module" "rescue" "when" "unless"
                              "private")
                      eow))
                 (outline-minor-mode))))

(add-hook 'rspec-mode-hook
              (function
               (lambda ()
                 (defun rspec-outline-level ()
               (or (and (match-string 1)
                        (or (cdr (assoc (match-string 1) outline-heading-alist))
                                (- (match-end 1) (match-beginning 1))))
                       (cdr (assoc (match-string 0) outline-heading-alist))
                       (- (match-end 0) (match-beginning 0))))

                 (set (make-local-variable 'outline-level) 'rspec-outline-level)

                 (set (make-local-variable 'outline-regexp)
                      (rx (group (* " "))
                      bow
                      (or "context" "describe" "it" "subject")
                      eow))
                 (outline-minor-mode))))

;; ================================================================
;; flymake関係
;; ================================================================

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'flymake-haml)
(add-hook 'haml-mode-hook 'flymake-haml-load)

(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)

(require 'flymake-coffee)
(add-hook 'coffee-mode-hook 'flymake-coffee-load)

;; ================================================================
;; Use the right Ruby with Emacs and rbenv - Fist of Senn
;; - http://blog.senny.ch/blog/2013/02/11/use-the-right-ruby-with-emacs-and-rbenv/
;; ================================================================
;; (prelude-require-package 'rbenv)

;; ;; Setting rbenv path
;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;                        (getenv "HOME") "/.rbenv/bin:"
;;                        (getenv "PATH")))
;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;; ================================================================
;; 賢いコンパイル
;; ================================================================

(require 'smart-compile)

(define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
(define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

(setq smart-compile-alist
      (quote ((emacs-lisp-mode emacs-lisp-byte-compile)
              (html-mode browse-url-of-buffer)
              (nxhtml-mode browse-url-of-buffer)
              (html-helper-mode browse-url-of-buffer)
              (octave-mode run-octave)
              ("\\.c\\'" . "gcc -O2 %f -lm -o %n")
              ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
              ("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
              ("\\.java\\'" . "javac %f")
              ("\\.php\\'" . "php -l %f")
              ("\\.f90\\'" . "gfortran %f -o %n")
              ("\\.[Ff]\\'" . "gfortran %f -o %n")
              ("\\.cron\\(tab\\)?\\'" . "crontab %f")
              ("\\.tex\\'" tex-file)
              ("\\.texi\\'" . "makeinfo %f")
              ("\\.mp\\'" . "mptopdf %f")
              ("\\.pl\\'" . "perl -cw %f")
              ("\\.rb\\'" . "bundle exec ruby %f"))))

;; ================================================================
;; Emacsで保存時にFirefoxのタブを探してリロード - Qiita [キータ]
;; - http://qiita.com/hakomo/items/9a99115f8911b55957bb
;; ================================================================
(require 'moz)

(defun my/reload-firefox ()
      "Reload firefox."
      (interactive)
      (comint-send-string (inferior-moz-process) "BrowserReload();"))

(defun my/run-rake-yard ()
      "Run rake yard."
      (interactive)
      (shell-command "rake yard"))

(define-key ruby-mode-map (kbd "C-c y") (lambda ()
                                              (interactive)
                                              (my/run-rake-yard)
                                              (my/reload-firefox)))

(when (or (eq system-type 'windows-nt)
              (eq system-type 'cygwin))
      (setq file-name-coding-system 'cp932)
      
      ;; Ctrl-gとかでベルを鳴らさないようにします。
      (setq visible-bell t)
      (setq ring-bell-function 'ignore)
      
      ;;;** 標準IMEの設定
      (setq default-input-method "W32-IME")
      
      ;;;** IMEの初期化
      (w32-ime-initialize)
      
      ;;;** IME状態のモードライン表示
      (setq-default w32-ime-mode-line-state-indicator "[--]")
      (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      
      ;;;** IME OFF時の初期カーソルカラー
      (set-cursor-color "red")
      
      ;;;** IME ON/OFF時のカーソルカラー
      (add-hook 'input-method-activate-hook
                    (lambda() (set-cursor-color "green")))
      (add-hook 'input-method-inactivate-hook
                    (lambda() (set-cursor-color "red")))
      
      ;;;** バッファ切り替え時にIME状態を引き継ぐ
      (setq w32-ime-buffer-switch-p nil)
      
      ;;;** Ctrl-Oでトグルするようにする
      (global-set-key (kbd "C-o") 'toggle-input-method)
      
      ;; ;; cp932エンコード時の表示を「P」とする
      ;; (coding-system-put 'cp932 :mnemonic ?P)
      ;; (coding-system-put 'cp932-dos :mnemonic ?P)
      ;; (coding-system-put 'cp932-unix :mnemonic ?P)
      ;; (coding-system-put 'cp932-mac :mnemonic ?P)
)

(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

(require 'sbt-mode)

;バッファのフォントサイズを大きく
(global-set-key (kbd "<prior>") 'text-scale-increase)
;バッファのフォントサイズを小さく
(global-set-key (kbd "<next>")  'text-scale-decrease)

(when (eq system-type 'gnu/linux)
      (global-set-key (kbd "C-o") 'toggle-input-method))

(defun my/fullscreen ()
      (interactive)
      (set-frame-parameter
       nil
       'fullscreen
       (if (frame-parameter nil 'fullscreen)
       nil
         'fullboth)))
(global-set-key [f11] 'my/fullscreen)

;; (defun my/open-init-folder()
;;   "設定フォルダを開きます．"
;;   (interactive)
;;   (find-file "~/.emacs.d/init.org"))
;; (global-set-key (kbd "<f1>") 'my/open-init-folder)


(defun my/other-window-backward ()
      "Move to other window backward."
      (interactive)
      (other-window -1))

(define-prefix-command 'personal-map)
(global-set-key (kbd "C-.") 'personal-map)

(define-key 'personal-map (kbd "?") 'help-command)

(define-key 'personal-map (kbd "C-n") 'other-window)
(define-key 'personal-map (kbd "C-p") 'my/other-window-backward)

(define-key 'personal-map (kbd "m") 'imenu)

(define-key 'personal-map (kbd "i") 'yas-insert-snippet)
(define-key 'personal-map (kbd "n") 'yas-new-snippet)
(define-key 'personal-map (kbd "v") 'yas-visit-snippet-file)

(define-key 'personal-map (kbd "y") 'helm-c-yas-complete)
(define-key 'personal-map (kbd "s") 'helm-c-yas-create-snippet-on-region)

(define-key 'personal-map (kbd "b") 'org-beamer-export-to-pdf)

(cond ((eq system-type 'gnu/linux)
       (define-key 'personal-map (kbd "p") 'evince-forward-search))
      ((eq system-type 'darwin)
       (define-key 'personal-map (kbd "p") 'skim-forward-search)))

(use-package ace-jump-mode
             :disabled
             :bind (("C-." . ace-jump-mode)
                    ("C-," . ace-jump-line-mode))
             :ensure t)

##  (add-hook 'before-save-hook
##   'whitespace-cleanup)

;;  (require 'mu4e)

;;  (setq mu4e-maildir       "~/Maildir")
;;  (setq mu4e-sent-folder   "/[Gmail].All Mail")
;;  (setq mu4e-drafts-folder "/[Gmail].Drafts")
;;  (setq mu4e-trash-folder  "/[Gmail].Trash")
;;  (setq mu4e-refile-folder "/[Gmail].All Mail")

;;  (setq mu4e-sent-messages-behavior 'delete)

;; (setq mu4e-maildir-shortcuts
;;       '( ("/INBOX"             . ?i)
;;          ("/[Gmail].All Mail"  . ?a)
;;          ("/[Gmail].Drafts"    . ?d)
;;          ("/[Gmail].Trash"     . ?t)))

;; (require 'smtpmail)
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'starttls
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;;  (setq message-kill-buffer-on-exit t)

;;  (setq mu4e-show-images t)

;;  (when (fboundp 'imagemagick-register-types)
;;    (imagemagick-register-types))

;;  (setq mu4e-msg2pdf "/usr/bin/msg2pdf")

;;  (add-to-list 'mu4e-view-actions
;;                 '("View in browser" . mu4e-action-view-in-browser) t)

;;  (setq mu4e-html2text-command "w3m -dump -T text/html")

;;  (add-to-list 'mu4e-bookmarks '("flag:flagged" "Flagged (Starred in Gmail)" ?s))

;;  (setq mu4e-headers-date-format "%y-%m-%d %H:%M")
;;  (setq mu4e-headers-time-format "%y-%m-%d %H:%M")

;; (setq mu4e-headers-fields
;;       '((:human-date . 14)
;;         (:flags . 6)
;;         (:from . 15)
;;         (:subject)))

;;  (setq mu4e-headers-skip-duplicates 't)

;;  (require 'org-mu4e)

;;  (defalias 'org-mail 'org-mu4e-compose-org-mode)

;;  (setq org-mu4e-convert-to-html t)

;;  (global-set-key (kbd "C-c m") 'mu4e)

;; (dolist (package '(php-mode))
;;   (when (not (package-installed-p package))
;;     (package-install package)))

(use-package ox-mediawiki :ensure t)

(message "%s" "%% Emacsの設定を開始します %%")

(add-hook 'input-method-activate-hook
              '(lambda () (set-cursor-color "green")))
(add-hook 'input-method-inactivate-hook
              '(lambda () (set-cursor-color "orchid")))
