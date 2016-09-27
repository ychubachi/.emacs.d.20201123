;; init.el --- Emacsの初期設定

;;; 説明

;;;; Mac用Emacsについて
;; - Emacs Mac Portを仕様

;; Macで本家EmacsとHomebrew IMEパッチ版とEmacs Mac PortとAquamacsを比べてみる。 | たったのセブンクレジット
;;   (browse-url "http://www.sevencredit.com/2014/07/02/580/")

;; Downloads · railwaycat/emacs-mac-port Wiki
;;   (browse-url "https://github.com/railwaycat/emacs-mac-port/wiki/Downloads")

;; Macで本家EmacsとHomebrew IMEパッチ版とEmacs Mac PortとAquamacsを比べてみる。 | たったのセブンクレジット
;;   (browse-url "http://www.sevencredit.com/2014/07/02/580/")

;;; 基本設定

;;; describe-personal-keybindings をバインドします
(bind-key "C-c d" 'describe-personal-keybindings)

;;; 未整理
;;; Clean Mode Line
;; - mode-lineのモード情報をコンパクトに表示する- Life is very short
;;   - http://d.hatena.ne.jp/syohex/20130131/1359646452

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

;;; フォントサイズをPU，PDで変更できるようにする

;;; - Page Up，Page Downで操作
;;; - Macの場合はfn+↑，fn+↓
(global-set-key (kbd "<prior>") 'text-scale-increase)
(global-set-key (kbd "<next>")  'text-scale-decrease)

;;; eldoc
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
(setq eldoc-idle-delay 0.2)
(setq eldoc-minor-mode-string "")

;; *** package listをhelmで選択

;; * カスタマイズ
;; カスタマイズ設定を保存するファイルの指定
;;   - 概要
;; 	 - カスタマイズ設定を保存するファイルを指定して，読み込みます．
;; 	   - custom.elには個人用の設定を書く
;; 	 - このコードで設定した値は，custom.el内で上書きすることができます．
;;   - 参考
;; 	 - [[http://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Customizations.html][Saving Customizations - GNU Emacs Manual]]

;; #+NAME: custom-file
;; #+begin_src emacs-lisp
;;   (setq custom-file "~/.emacs.d/custom.el")
;;   (if (file-exists-p custom-file)
;; 	  (load custom-file))
;; #+end_src

;; #+PROPERTY: header-args:emacs-lisp :tangle wip.el
;; #+PROPERTY: header-args            :results silent

;; * Ruby
;;   ;; S式から正規表現を作成する - by shigemk2
;;   ;; - http://d.hatena.ne.jp/shigemk2/20120419/1334762456

;;   ;; EmacsでRubyの開発環境をめちゃガチャパワーアップしたまとめ | Futurismo
;;   ;; http://hmi-me.ciao.jp/wordpress/archives/1295

;;   ;;; Code:

;;   ;; ================================================================
;;   ;; パッケージのインストール
;;   ;; ================================================================

;; #+begin_src emacs-lisp
;;   (autoload 'ruby-mode "ruby-mode"
;; 	"Mode for editing ruby source files" t)
;;   (require 'ruby-mode)

;;   ;; ================================================================
;;   ;; Ruby DSLs
;;   ;; ================================================================

;;   (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
;;   (add-to-list 'auto-mode-alist '("Berksfile" . ruby-mode))

;;   ;; ================================================================
;;   ;; outline-minnor-mode
;;   ;; ================================================================

;;   (require 'outline)
;;   (add-hook 'ruby-mode-hook
;; 		(function
;; 		 (lambda ()
;; 		   (defun ruby-outline-level ()
;; 		 (or (and (match-string 1)
;; 			  (or (cdr (assoc (match-string 1) outline-heading-alist))
;; 				  (- (match-end 1) (match-beginning 1))))
;; 			 (cdr (assoc (match-string 0) outline-heading-alist))
;; 			 (- (match-end 0) (match-beginning 0))))

;; 		   (set (make-local-variable 'outline-level) 'ruby-outline-level)

;; 		   (set (make-local-variable 'outline-regexp)
;; 			(rx (group (* " "))
;; 			bow
;; 			(or "begin" "case" "class" "def" "else" "elsif"
;; 				"ensure" "if" "module" "rescue" "when" "unless"
;; 				"private")
;; 			eow))
;; 		   (outline-minor-mode))))

;;   (add-hook 'rspec-mode-hook
;; 		(function
;; 		 (lambda ()
;; 		   (defun rspec-outline-level ()
;; 		 (or (and (match-string 1)
;; 			  (or (cdr (assoc (match-string 1) outline-heading-alist))
;; 				  (- (match-end 1) (match-beginning 1))))
;; 			 (cdr (assoc (match-string 0) outline-heading-alist))
;; 			 (- (match-end 0) (match-beginning 0))))

;; 		   (set (make-local-variable 'outline-level) 'rspec-outline-level)

;; 		   (set (make-local-variable 'outline-regexp)
;; 			(rx (group (* " "))
;; 			bow
;; 			(or "context" "describe" "it" "subject")
;; 			eow))
;; 		   (outline-minor-mode))))

;;   ;; ================================================================
;;   ;; Use the right Ruby with Emacs and rbenv - Fist of Senn
;;   ;; - http://blog.senny.ch/blog/2013/02/11/use-the-right-ruby-with-emacs-and-rbenv/
;;   ;; ================================================================
;;   ;; (prelude-require-package 'rbenv)

;;   ;; ;; Setting rbenv path
;;   ;; (setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
;;   ;;                        (getenv "HOME") "/.rbenv/bin:"
;;   ;;                        (getenv "PATH")))
;;   ;; (setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
;;   ;;                       (cons (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

;;   ;; ================================================================
;;   ;; 賢いコンパイル
;;   ;; ================================================================

;;   (require 'smart-compile)

;;   (define-key ruby-mode-map (kbd "C-c c") 'smart-compile)
;;   (define-key ruby-mode-map (kbd "C-c C-c") (kbd "C-c c C-m"))

;;   (setq smart-compile-alist
;; 	(quote ((emacs-lisp-mode emacs-lisp-byte-compile)
;; 		(html-mode browse-url-of-buffer)
;; 		(nxhtml-mode browse-url-of-buffer)
;; 		(html-helper-mode browse-url-of-buffer)
;; 		(octave-mode run-octave)
;; 		("\\.c\\'" . "gcc -O2 %f -lm -o %n")
;; 		("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
;; 		("\\.m\\'" . "gcc -O2 %f -lobjc -lpthread -o %n")
;; 		("\\.java\\'" . "javac %f")
;; 		("\\.php\\'" . "php -l %f")
;; 		("\\.f90\\'" . "gfortran %f -o %n")
;; 		("\\.[Ff]\\'" . "gfortran %f -o %n")
;; 		("\\.cron\\(tab\\)?\\'" . "crontab %f")
;; 		("\\.tex\\'" tex-file)
;; 		("\\.texi\\'" . "makeinfo %f")
;; 		("\\.mp\\'" . "mptopdf %f")
;; 		("\\.pl\\'" . "perl -cw %f")
;; 		("\\.rb\\'" . "bundle exec ruby %f"))))

;;   ;; ================================================================
;;   ;; Emacsで保存時にFirefoxのタブを探してリロード - Qiita [キータ]
;;   ;; - http://qiita.com/hakomo/items/9a99115f8911b55957bb
;;   ;; ================================================================
;;   (require 'moz)

;;   (defun my/reload-firefox ()
;; 	"Reload firefox."
;; 	(interactive)
;; 	(comint-send-string (inferior-moz-process) "BrowserReload();"))

;;   (defun my/run-rake-yard ()
;; 	"Run rake yard."
;; 	(interactive)
;; 	(shell-command "rake yard"))

;;   (define-key ruby-mode-map (kbd "C-c y") (lambda ()
;; 						(interactive)
;; 						(my/run-rake-yard)
;; 						(my/reload-firefox)))
;; #+end_src

;; * Scala
;;   - 参考
;; 	- [[http://futurismo.biz/archives/2449][EmacsでScala開発環境を構築(Ensime) | Futurismo]]

;; #+begin_src emacs-lisp
;; (require 'ensime)
;; (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;; (require 'sbt-mode)
;; #+end_src
;; * キーバインディング

;;   (defun my/other-window-backward ()
;; 	"Move to other window backward."
;; 	(interactive)
;; 	(other-window -1))
;; #+end_src

;; #+begin_src emacs-lisp
;;   (define-prefix-command 'personal-map)
;;   (global-set-key (kbd "C-.") 'personal-map)

;;   (define-key 'personal-map (kbd "C-n") 'other-window)
;;   (define-key 'personal-map (kbd "C-p") 'my/other-window-backward)

;;   (define-key 'personal-map (kbd "m") 'imenu)

;;   (define-key 'personal-map (kbd "i") 'yas-insert-snippet)
;;   (define-key 'personal-map (kbd "n") 'yas-new-snippet)
;;   (define-key 'personal-map (kbd "v") 'yas-visit-snippet-file)

;;   (define-key 'personal-map (kbd "y") 'helm-c-yas-complete)
;;   (define-key 'personal-map (kbd "s") 'helm-c-yas-create-snippet-on-region)

;;   (define-key 'personal-map (kbd "b") 'org-beamer-export-to-pdf)

;;   (cond ((eq system-type 'gnu/linux)
;; 	 (define-key 'personal-map (kbd "p") 'evince-forward-search))
;; 	((eq system-type 'darwin)
;; 	 (define-key 'personal-map (kbd "p") 'skim-forward-search)))
;; #+end_src

;; * TODO auto-complete - 自動補間
;;   - [[http://cx4a.org/software/auto-complete/index.ja.html][Auto Complete Mode - GNU Emacsのための最も賢い自動補完機能]]

;; * TODO Macでフォントを正しく設定する
;;    :PROPERTIES:
;;    :ID:       16b070ee-507e-49fa-b84d-fa573911ebeb
;;    :END:

;; - let* は，同じスコープ内のローカル変数への参照を許す(letは許さない）
;; - ifはthenを1つの式しか書けないのでcondを使う．whenもある．
;; - [[http://blog.sanojimaru.com/post/19807398882/cocoa-emacs-ricty][cocoa emacsでプログラミング用フォントRictyを使う]]
;;   ｰ この記事，あやしいかも．
;; - daemonで動かすとおちるかも

;; * TODO mu4e [[https://github.com/ychubachi/.emacs.d/blob/master/plugins-available/mu4e.org][(GitHub)]]
;; ** 概要
;; mu4eは，offlineimap及びmaildir-toolsと組み合わせることで動作する，
;; Gmail等IMAPサーバに対応する軽快なメールリーダである．

;; ** 外部ツール
;; *** OfflineImap
;; **** IMAP版のDropboxのようなもの
;; OfflineImapは，IMAPサーバにあるメールをローカルのファイルに
;; Maildir形式で同期するツールである．DropboxやOneDriveのIMAP版と考えれば
;; 分かりやすいかもしれない．

;; OfflineImapをバックグラウンドで定期的に実行することで，
;; 手元にあるローカルファイルが，IMAPサーバ上にあるメールと同期する．
;; OfflineImapは，新しいメールが届いていればダウンロードし，
;; ローカルでメールを削除したら，サーバのメールも削除する．

;; **** Gmailでの利用
;; ここでは，Gmailを利用することを前提に，
;; OfflineImapを設定する．

;; まず，Gmail側で設定を行う．
;; IMAPのフォルダ名を英語にするため，Gmailは「英語」の設定にする．
;; 実は，日本語のフォルダ名を，offlineimapのnametrans機能で
;; 日本語に変換することもできる．

;; しかしながら，
;; 筆者が試行錯誤したところ，このことに起因すると思われる
;; 文字コードに関連したエラーが発生してしまった．
;; 安定的な動作を期するため，Gmailの設定画面において、
;; 「使用する言語」を英語にしておくのが良さそうだ．

;; **** OfflineImapコマンドのインストール

;; #+begin_src sh
;;  sudo apt-get install offlineimap
;; #+end_src

;; - 設定例
;;   - [[https://github.com/spaetz/offlineimap/blob/master/offlineimap.conf][offlineimap/offlineimap.conf at master · spaetz/offlineimap]]

;; .netrcに，imapのログイン名とパスワードを書いておく．

;; 初回実行したら，97,388件のメールをダウンロードするのに508分55秒かかった．

;; **** バックグラウンドでの実行

;; offlineimapをバックグラウンドで動作させるにはいくつかの方法がある．
;; 手軽に始められる方法として以下のやり方がある．

;; #+begin_src sh
;;   (zsh)$  offlineimap &!
;;   (bash)$ nohup offlineimap &
;; #+end_src

;; **** 関連URL
;; - [[http://docs.offlineimap.org/en/latest/][Welcome to offlineimaps‘s documentation — OfflineImap 6.5.4 documentation]]
;; - [[http://gihyo.jp/admin/serial/01/ubuntu-recipe/0247?page=1][第247回　Offlineimap＋Dovecotによる快適メール環境：Ubuntu Weekly Recipe｜gihyo.jp … 技術評論社]]
;; - [[http://piao-tech.blogspot.jp/2010/03/get-offlineimap-working-with-non-ascii.html][私のTech記憶: Get offlineimap working with non ASCII characters.]]

;; *** mu
;; **** muを用いてメールを素早く検索

;; muは，MaildirにあるメールをDB化する．
;; 表示や検索が素早く行えるようになる．
;; 検索が優れているので，ファルダを利用してメールを整理する必要がなくなる．
;; Gmailでラベルを使用していたが，muでの検索機能が優れているので，全て削除した．

;; - mu (maildir-utils)
;;   - [[http://www.djcbsoftware.nl/code/mu/mu4e/index.html#Top][mu4e user manual]]
;;   - [[http://code.google.com/p/mu0/downloads/detail?name=mu4e-manual-0.9.9.pdf][mu4e-manual-0.9.9.pdf - mu0 - mu4e v0.9.9 manual - mu is a collection of utilties for indexing and searching Maildirs - Google Project Hosting]]
;;   - [[https://github.com/djcb/mu][djcb/mu]]
;;   - [[http://www.brool.com/index.php/using-mu4e][Using mu4e | brool]]



;; - インストール
;;   - sudo apt-get install mu4e mildir-utils-extra

;; - mu index

;; こちらは510.57秒．

;; ** Emacsのカスタマイズ
;; - custom.el
;;   (user-mail-address "yoshi@chubachi.net")
;;   (user-full-name  "Yoshihide Chubachi")
;;   (message-signature "Yoshihide Chubachi @AIIT")
;;   (smtpmail-smtp-user "yoshihide.chubachi@gmail.com")

;; - これはよくわからない
;;   '(mu4e-user-mail-address-list (quote ("yc@aiit.ac.jp" "yoshi@chubachi.net" "yoshihide.chubachi@gmail.com")))

;; ** Emacsの設定ファイル
;; *** パッケージの読み込み
;; #+begin_src emacs-lisp
;; ;;  (require 'mu4e)
;; #+end_src

;; *** Gmail用Maildirフォルダの指定
;; mu4eで用いるGmailのフォルダを指定する．
;; GmailのSentフォルダは設定せず，All Mailフォルダを指定する．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-maildir       "~/Maildir")
;; ;;  (setq mu4e-sent-folder   "/[Gmail].All Mail")
;; ;;  (setq mu4e-drafts-folder "/[Gmail].Drafts")
;; ;;  (setq mu4e-trash-folder  "/[Gmail].Trash")
;; ;;  (setq mu4e-refile-folder "/[Gmail].All Mail")
;; #+end_src

;; don't save message to Sent Messages, Gmail/IMAP takes care of this

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-sent-messages-behavior 'delete)
;; #+end_src

;; 	  ;; setup some handy shortcuts
;; 	  ;; you can quickly switch to your Inbox -- press ``ji''
;; 	  ;; then, when you want archive some messages, move them to
;; 	  ;; the 'All Mail' folder by pressing ``ma''.

;; rでrefileしたほうが便利．

;; #+begin_src emacs-lisp
;;   ;; (setq mu4e-maildir-shortcuts
;;   ;;       '( ("/INBOX"             . ?i)
;;   ;;          ("/[Gmail].All Mail"  . ?a)
;;   ;;          ("/[Gmail].Drafts"    . ?d)
;;   ;;          ("/[Gmail].Trash"     . ?t)))
;; #+end_src

;; SMTPの設定．Emacs標準のコンポーネント．

;; #+begin_src emacs-lisp
;;   ;; (require 'smtpmail)
;;   ;; (setq message-send-mail-function 'smtpmail-send-it
;;   ;;       smtpmail-stream-type 'starttls
;;   ;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;   ;;       smtpmail-smtp-server "smtp.gmail.com"
;;   ;;       smtpmail-smtp-service 587)
;; #+end_src

;; - [[http://www.djcbsoftware.nl/code/mu/mu4e/Retrieval-and-indexing.html#Retrieval-and-indexing][Retrieval and indexing - mu4e user manual]]

;;   ;; don't keep message buffers around
;; #+begin_src emacs-lisp
;; ;;  (setq message-kill-buffer-on-exit t)
;; #+end_src


;;   ;; show images
;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-show-images t)
;; #+end_src

;;   ;; use imagemagick, if available
;; #+begin_src emacs-lisp
;; ;;  (when (fboundp 'imagemagick-register-types)
;; ;;    (imagemagick-register-types))

;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-msg2pdf "/usr/bin/msg2pdf")
;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (add-to-list 'mu4e-view-actions
;; ;;		   '("View in browser" . mu4e-action-view-in-browser) t)
;; #+end_src

;; HTML形式のメールをEmacs内で読むためにテキスト形式に整形するための
;; コマンドを指定する．
;; html2textも利用できるが，Shift JISに対応していない．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-html2text-command "w3m -dump -T text/html")
;; #+end_src

;; Gmailでスターをつけると，flagが付く．
;; そこで，これを検索するブックマークを追加する．

;; #+begin_src emacs-lisp
;; ;;  (add-to-list 'mu4e-bookmarks '("flag:flagged" "Flagged (Starred in Gmail)" ?s))
;; #+end_src

;; ヘッダ一覧画面に表示される日付と時刻の表示形式を設定する．
;; 当日のメールにも日付が表示されるようにした．

;; #+begin_src emacs-lisp
;; ;;  (setq mu4e-headers-date-format "%y-%m-%d %H:%M")
;; ;;  (setq mu4e-headers-time-format "%y-%m-%d %H:%M")
;; #+end_src

;; ヘッダーに表示する列と幅を指定する．

;; #+begin_src emacs-lisp
;;   ;; (setq mu4e-headers-fields
;;   ;;       '((:human-date . 14)
;;   ;;         (:flags . 6)
;;   ;;         (:from . 15)
;;   ;;         (:subject)))
;; #+end_src

;; メールが/INDEXと/[Gmail]/All Mailの両方に存在する状態の場合，
;; 検索結果に両方が含まれる．次の設定をすることにより，
;; 重複を除外して表示する．

;; #+begin_src emacs-lisp
;;   ;;  (setq mu4e-headers-skip-duplicates 't)
;; #+end_src

;; *** org-mode対応

;; #+begin_src emacs-lisp
;; ;;  (require 'org-mu4e)
;; #+end_src

;; #+begin_src emacs-lisp
;; ;;  (defalias 'org-mail 'org-mu4e-compose-org-mode)
;; #+end_src

;;   ;; convert org mode to HTML automatically
;; #+begin_src emacs-lisp
;; ;;  (setq org-mu4e-convert-to-html t)
;; #+end_src
;; ** キーバインド

;; #+begin_src emacs-lisp
;; ;;  (global-set-key (kbd "C-c m") 'mu4e)
;; #+end_src
;; * TODO Todo List
;; ** TODO org-insert-heading-respect-contentをC-jにする
;;    :PROPERTIES:
;;    :ID:       f9593ce6-203d-47a7-9342-fd602c193a0c
;;    :END:
;;    C-jはorg-return-indentにバインドされている
;; ** TODO [[http://www.emacswiki.org/emacs/UnitTesting][EmacsWiki: Unit Testing]]
;;    :PROPERTIES:
;;    :ID:       5cb66ace-65c3-4e01-9c1c-f25ae7008668
;;    :END:
;; ** TODO [[https://github.com/purcell/exec-path-from-shell][purcell/exec-path-from-shell]]
;;    :PROPERTIES:
;;    :ID:       cd8617f9-5634-467f-9c14-ca657a802726
;;    :END:
;; ** TODO flyspell-modeでC-.がかちあう
;;    :PROPERTIES:
;;    :ID:       7af985a9-1630-4e8a-8202-3d434351c518
;;    :END:
;; ** TODO [[http://shibayu36.hatenablog.com/entry/2012/12/29/001418][年末emacs設定大掃除をして、これは捨てられないと思った設定書いてく - $shibayu36->blog;]]
;;    :PROPERTIES:
;;    :ID:       e010dd60-ee65-4042-9b16-9ae0f2681837
;;    :END:
;; ** TODO Qiitaに投稿できないか
;;    :PROPERTIES:
;;    :ID:       7cd92222-91c7-4c46-9325-85e891c20216
;;    :END:
;; ** TODO org-modeで候補をインラインにできないか
;;    :PROPERTIES:
;;    :ID:       0d60c33f-5d9b-4447-bf76-8344bf44471c
;;    :END:
;; ** TODO [[http://www.fan.gr.jp/~ring/doc/elisp_19/elisp-jp_39.html][GNU Emacs Lispリファレンス・マニュアル: A. ヒントと標準的な作法]]
;; ** TODO 参考文献

;;  Emacs LISP テクニックバイブル

;; - p.31より
;; ** TODO os-name

;; [[http://wisdom.sakura.ne.jp/programming/lisp/clisp11.html][condとcase]]

;; (defun convert-system-type-to-os-name ()
;;   (cond ((eq system-type 'gnu/linux) 'linux)
;; 	((eq system-type 'darwin) 'osx)
;; 	((eq system-type 'windows-nt) 'windows)
;; 	((eq system-type 'cygwin) 'cygwin)
;; 	(t 'unknown)))

;; (convert-system-type-to-os-name)	; => linux

;; (let (custom-file-system-name)
;;   (setq custom-file-system-name
;; 	(format "custom-%s.el" system-type)) ; => "custom-gnu/linux.el"
;;   (message custom-file-system-name))		   ; => "custom-gnu/linux.el"

;; * TODO PHP

;; #+begin_src emacs-lisp
;;   ;; (dolist (package '(php-mode))
;;   ;;   (when (not (package-installed-p package))
;;   ;;     (package-install package)))
;; #+end_src

;; * TODO mediawiki export
;;   - packageでインストールできなさそう

;; #+NAME: ox-mediawiki
;; #+begin_src emacs-lisp
;;   (use-package ox-mediawiki :ensure t)
;; #+end_src

;; * TODO 開始の通知

;; #+begin_src emacs-lisp
;;  (message "%s" "%% Emacsの設定を開始します %%")
;; #+end_src

;; * TODO after-init-hookの設定
;;   - after-init-hookはパッケージの初期化が完了したら呼ばれるフックです．
;; 	- [[http://www.gnu.org/software/emacs/manual/html_node/elisp/Init-File.html#Init-File][Init File - GNU Emacs Lisp Reference Manual]]

;; #+begin_src emacs-lisp
;; 	(add-hook 'after-init-hook
;; 		  (lambda ()
;; 		(message "%s" "%% custom.elを読み込みました %%")))
;; #+end_src

;; * TODO Caskの設定
;; #+begin_src emacs-lisp
;; (require 'cask "~/.cask/cask.el")
;; (cask-initialize)
;; #+end_src


;; * TODO org-page
;;   - [[https://github.com/kelvinh/org-page][kelvinh/org-page]]
;;   - 新しいリポジトリを作る
;; 	- op/new-repository
;;   ｰ 公開
;; 	- op/do-publication

;; #+begin_src emacs-lisp
;; (require 'org-page)
;; #+end_src

;; * TODO WordPressに記事を投稿（org2blog）
;; ** 利用法
;;   - org2blogを使うと，subtreeをwordpressに投稿できる．
;;   - 使い方は [[https://github.com/punchagan/org2blog][punchagan/org2blog]] を参照．

;;    |--------------------------+--------------------------|
;;    | 機能                     | コマンド                 |
;;    |--------------------------+--------------------------|
;;    | 下位層を投稿             | org2blog/wp-post-subtree |
;;    |--------------------------+--------------------------|
;;    | ログイン                 | org2blog/wp-login        |
;;    | 新規投稿                 | org2blog/wp-new-entry    |
;;    |--------------------------+--------------------------|
;;    | 草稿として投稿           | C-c d                    |
;;    | 公開                     | C-c p                    |
;;    | 草稿として草稿（ページ） | C-c D                    |
;;    | 公開（ページ）           | C-c P                    |
;;    |--------------------------+--------------------------|

;; 1. キャプチャして新しい記事を作成
;; 2. 投稿したいエントリのヘッダにカーソルを移動して
;;    org2blog/wp-new-entry
;;    -> ログインしてなければログインが促される
;; 3. ブラウザで確認

;; ** 導入

;; #+begin_src emacs-lisp
;;   (require 'org2blog-autoloads)
;; #+end_src

;; ** 手動設定

;; - wordpressのログイン情報をcustom.el内に記述

;; ** ソースコードを投稿できるようにする

;; #+begin_src emacs-lisp
;;   (setq org2blog/wp-use-sourcecode-shortcode t)
;; #+end_src

;; ** 備考
;;    - ソースコードを表示させるには
;; 	 [[http://wordpress.org/plugins/syntaxhighlighter/][WordPress › SyntaxHighlighter Evolved « WordPress Plugins]]
;; 	 をインストールしておく．
;;    - emacs lispには対応していない．残念．

;; * TODO system-typeに応じたcustom.el

;; #+begin_src emacs-lisp
;;   (let (custom-file-system-name)
;; 	(setq custom-file-system-name
;; 	  (format "~/.emacs.d/custom/%s.el" (system-name)))
;; 	(when (file-exists-p custom-file-system-name)
;; 	  (message "%s" (format "%sを読み込みます" custom-file-system-name))
;; 	  (load custom-file)))
;; #+end_src

;; * TODO markdownモードでアウトラインを有効にする
;; - markdown-mode-hook 定義されてない？
;; #+begin_src emacs-lisp
;;   (add-hook 'markdown-mode-hook
;; 		'(lambda () (outline-minor-mode t)))
;; #+end_src

;; * TODO Windows用設定
;; ** TODO 設定全体

;; #+begin_src emacs-lisp :noweb yes
;;   (when (or (eq system-type 'windows-nt)
;; 		(eq system-type 'cygwin))
;; 	<<windows-settings>>
;;   )
;; #+end_src

;; ** Windows用設定

;; #+name: windows-settings
;; #+begin_src emacs-lisp :tangle no
;;   (setq file-name-coding-system 'cp932)

;;   ;; Ctrl-gとかでベルを鳴らさないようにします。
;;   (setq visible-bell t)
;;   (setq ring-bell-function 'ignore)

;;   ;;;** 標準IMEの設定
;;   (setq default-input-method "W32-IME")

;;   ;;;** IMEの初期化
;;   (w32-ime-initialize)

;;   ;;;** IME状態のモードライン表示
;;   (setq-default w32-ime-mode-line-state-indicator "[--]")
;;   (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))

;;   ;;;** IME OFF時の初期カーソルカラー
;;   (set-cursor-color "red")

;;   ;;;** IME ON/OFF時のカーソルカラー
;;   (add-hook 'input-method-activate-hook
;; 		(lambda() (set-cursor-color "green")))
;;   (add-hook 'input-method-inactivate-hook
;; 		(lambda() (set-cursor-color "red")))

;;   ;;;** バッファ切り替え時にIME状態を引き継ぐ
;;   (setq w32-ime-buffer-switch-p nil)

;;   ;; ;; cp932エンコード時の表示を「P」とする
;;   ;; (coding-system-put 'cp932 :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-dos :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-unix :mnemonic ?P)
;;   ;; (coding-system-put 'cp932-mac :mnemonic ?P)
;; #+end_src

;; * TODO graphviz-dot-mode
;;   - .dot ファイルをgraphviz-dot-modeで開くようにします．

;; #+begin_src emacs-lisp
;; (setq graphviz-dot-preview-extension "pdf")
;; #+end_src

;; * TODO Helm
;; ** TODO C-k
;; ミニバッファで C-k 入力時にカーソル以降を削除する

;; #+begin_src emacs-lisp
;; (setq helm-delete-minibuffer-contents-from-point t)
;; #+end_src

;; ** TODO 他のパッケージ

;; #+begin_src emacs-lisp
;; (dolist (package '(
;; 		   helm-themes
;; 		   imenu-anywhere
;; 		   helm-c-yasnippet))
;;   (when (not (package-installed-p package))
;; 	(package-install package)))
;; #+end_src

;; #+begin_src emacs-lisp
;; (require 'helm-command)

;; (setq helm-idle-delay             0.1
;; 	  helm-input-idle-delay       0.1
;; 	  helm-candidate-number-limit 200)
;; #+end_src


;; #+begin_src emacs-lisp
;; (require 'helm-imenu)
;; (setq imenu-auto-rescan t)
;; (setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

;; (require 'helm-themes)

;; (require 'helm-c-yasnippet)
;; #+end_src

;;; custum.el
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/data/backup/" t))))
 '(auto-save-list-file-prefix "~/.emacs.d/data/auto-save-list/saves-")
 '(backup-directory-alist (quote (("\\.*$" . "~/.emacs.d/data/backup"))))
 '(bookmark-default-file "~/.emacs.d/data/bookmarks")
 '(column-number-mode t)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(display-time-24hr-format t)
 '(display-time-default-load-average nil)
 '(display-time-mode t)
 '(global-auto-revert-mode t)
 '(inhibit-startup-screen t)
 '(mediawiki-site-alist
   (quote
    (("YC's MediaWiki" "http://wiki.chubachi.net/" "yc" "" "メインページ"))))
 '(message-signature "Yoshihide Chubachi @AIIT")
 '(mouse-drag-copy-region t)
 '(mouse-yank-at-point t)
 '(mu4e-attachment-dir "~/Downloads")
 '(mu4e-user-mail-address-list
   (quote
    ("yc@aiit.ac.jp" "yoshi@chubachi.net" "yoshihide.chubachi@gmail.com")))
 '(op/repository-directory "/home/yc/git/ychubachi.github.io")
 '(op/site-domain "http://ychubachi.github.io/")
 '(org-export-in-background nil)
 '(org-log-done (quote time))
 '(org-src-fontify-natively t)
 '(org2blog/wp-blog-alist
   (quote
    (("blog.chubachi.net" :url "http://blog.chubachi.net/xmlrpc.php" :username "yc" :password "6mX6fj4p2kZZ"))))
 '(outline-minor-mode-prefix "")
 '(send-mail-function (quote smtpmail-send-it))
 '(shell-pop-autocd-to-working-dir nil)
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell)))))
 '(shell-pop-universal-key "C-z")
 '(shell-pop-window-height 30)
 '(show-paren-mode t)
 '(smtpmail-smtp-user "yoshihide.chubachi@gmail.com")
 '(user-full-name "Yoshihide Chubachi")
 '(user-mail-address "yc@aiit.ac.jp"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "chocolate1" :slant normal))))
 '(org-column-title ((t (:background "grey30" :underline t :weight bold :height 135)))))
