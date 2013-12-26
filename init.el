;;; init.el --- A default init file.
;;; Commentary:

;; Author:	Y.Chubachi （中鉢 欣秀）
;; Created:	2013-06-04

;;; Code:

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
			  "http://melpa.milkbox.net/packages/")
			 ("org" .
			  "http://orgmode.org/elpa/")
			 ))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; ================================================================
;; org-mode
;; ================================================================
(dolist (package '(org org-plus-contrib))
  (when (not (package-installed-p package))
    (package-install package)))

;; ================================================================
;; load pathの設定
;; ================================================================
(let ((default-directory "~/.emacs.d/site-lisp/"))
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
