;;; init.el --- A default init file.
;;; Commentary:

;; Author:	Y.Chubachi （中鉢 欣秀）
;; Created:	2013-06-04

;;; Code:

;; ================================================================
;; load pathの設定
;; ================================================================
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; ================================================================
;; 日本語の設定
;; ================================================================
(set-language-environment "japanese")
(prefer-coding-system 'utf-8)

;; ================================================================
;; Backupの設定
;; ================================================================

;; create backup file in ~/.emacs.d/backup
(setq make-backup-files t)
(setq backup-directory-alist
  (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
    backup-directory-alist))

;; create auto-save file in ~/.emacs.d/backup
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))

;; ================================================================
;; 自作関数
;; ================================================================

(defun my/fullscreen ()
  (interactive)
  (set-frame-parameter
   nil
   'fullscreen
   (if (frame-parameter nil 'fullscreen)
       nil
     'fullboth)))

(defun my/open-init-folder()
  "設定フォルダを開きます．"
  (interactive)
  (dired "~/.emacs.d/"))

(defun my/open-note()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Note/index.org"))
  
(defun my/open-todo()
  "備忘録を開きます．"
  (interactive)
  (find-file "~/Dropbox/Todo/todo.txt"))

(defun my/open-project-folder()
  "プロジェクトフォルダを開きます．"
  (interactive)
  (dired "~/git/"))

;; ================================================================
;; キーバインディング
;; ================================================================

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key (kbd "C-c C-h") 'help-command)
(global-set-key (kbd "C-z") 'shell)

(global-set-key [f11] 'my/fullscreen)
(global-set-key (kbd "<f1>") 'my/open-init-folder)
(global-set-key (kbd "<f2>") 'my/open-note)
(global-set-key (kbd "<f3>") 'my/open-todo)
(global-set-key (kbd "<f4>") 'my/open-project-folder)

;; ================================================================
;; パッケージの初期設定
;; - パッケージをインストールするディレクトリの設定
;; - ダウンロードするリポジトリの設定
;; - 必要に応じてアーカイブ
;; ================================================================
(require 'package)
(setq package-user-dir "~/.emacs.d/packages/")
(setq package-archives '(("gnu" .
			  "http://elpa.gnu.org/packages/")
                         ("marmalade" .
			  "http://marmalade-repo.org/packages/")
			 ("melpa" .
			  "http://melpa.milkbox.net/packages/")))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; ================================================================
;; init-loaderの設定
;; - init-loaderのインストール
;; ================================================================
(when (not (package-installed-p 'init-loader))
  (package-install 'init-loader))
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")
; (setq init-loader-show-log-after-init nil)

;; ================================================================
;; Custom file
;; ================================================================
(setq custom-file "~/.emacs.d/custom.el")
(if (file-exists-p (expand-file-name "~/.emacs.d/custom.el"))
    (load (expand-file-name custom-file) t nil nil))
