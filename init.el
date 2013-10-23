;;; init.el --- A default init file.
;;; Commentary:

;; Author:	Y.Chubachi （中鉢 欣秀）
;; Created:	2013-06-04

;;; Code:

;; Add load path
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; My minimum settings

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 日本語の設定
;;
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;; (set-default-coding-systems 'utf-8)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-next-selection-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-8)
;; (set-clipboard-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Backupの設定
;;

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; キーバインディング
;;

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)
(global-set-key (kbd "C-z") 'shell)

(global-set-key (kbd "C-.") 'other-window)
(global-set-key (kbd "C-,") 'undo)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; 自作関数
;;

;; full screen
(defun my/fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
		       (if (frame-parameter nil 'fullscreen) nil 'fullboth)))
(global-set-key [f11] 'my/fullscreen)

(defun my/open-init-folder()
  "設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/"))
(global-set-key (kbd "<f1>") 'my/open-init-folder)

(defun my/open-note()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/index.org"))
(global-set-key (kbd "<f2>") 'my/open-note)
  
(defun my/open-todo()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Todo/todo.txt"))
(global-set-key (kbd "<f3>") 'my/open-todo)

(defun my/open-project-folder()
  "プロジェクトフォルダを開きます．"
  (interactive)
  (dired "~/git/"))
(global-set-key (kbd "<f4>") 'my/open-project-folder)






;; ================================================================
;; packageの初期設定
;; ================================================================
(require 'package)

;; ディレクトリの設定
(setq package-user-dir "~/.emacs.d/packages/")

;; リポジトリの設定
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")))

;; 全てのパッケージをアーカイブ
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; ================================================================
;; init-loaderの設定
;; ================================================================

;; init-loaderのインストール
(setq package-name 'init-loader)

;; パッケージがなければインストール
(when (not (package-installed-p package-name))
  (package-install package-name))

;; init-loaderの初期化
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;(setq init-loader-show-log-after-init nil)

;; ================================================================
;; Custom file
;; ================================================================
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom.el"))
    (load (expand-file-name custom-file) t nil nil))
