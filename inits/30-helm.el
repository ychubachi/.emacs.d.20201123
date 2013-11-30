;;; 30-helm-mode.el -- Additional ettings for helm
;;; Commentary:

;; Home · emacs-helm/helm Wiki
;; - https://github.com/emacs-helm/helm/wiki

;; AnythingからHelmに移行しました - memo
;; - http://sleepboy-zzz.blogspot.jp/2012/09/anythinghelm.html

;; NTEmacs @ ウィキ - helm を使うための設定 - @ｳｨｷﾓﾊﾞｲﾙ
;; - http://www49.atwiki.jp/ntemacs/m/pages/32.html

;; Emacs - helm-mode 有効時でも helm-find-files は無効にする - Qiita [キータ]
;; - http://qiita.com/akisute3@github/items/7c8ea3970e4cbb7baa97

;; NOTE: 逆引用符は`,'の引数を評価し、 リスト構造にその値を入れます。
;;
;; GNU Emacs Lispリファレンス・マニュアル: 12. マクロ
;; - http://www.fan.gr.jp/~ring/doc/elisp_19/elisp-jp_14.html#IDX592

;;; Code:

(eval-when-compile (require 'cl))

;; ================================================================
;; パッケージのインストール
;; ================================================================
(dolist (package '(helm-descbinds
		   helm-migemo
		   helm-themes
		   imenu-anywhere
		   yasnippet helm-c-yasnippet))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'helm-config)
(helm-mode 1)

(require 'helm-command)
(require 'helm-descbinds)

(setq helm-idle-delay             0.1
      helm-input-idle-delay       0.1
      helm-candidate-number-limit 200)

;; ================================================================
;; Keybindings
;; ================================================================

;; C-h でバックスペースと同じように文字を削除できるようにする
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; ミニバッファで C-k 入力時にカーソル以降を削除する
(setq helm-delete-minibuffer-contents-from-point t)

;; ================================================================
;; helm-migemo - ローマ字検索
;; ================================================================

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

;; ================================================================
;; その他
;; ================================================================
(require 'helm-imenu)
(setq imenu-auto-rescan t)
(setq imenu-after-jump-hook (lambda () (recenter 10))) ; 選択後の表示位置を調整

(require 'helm-themes)

(require 'helm-c-yasnippet)

;; ================================================================
;; package listをhelmで選択
;; (This package is installed in vendor directory.)
;; ================================================================
(require 'helm-package)

;;; 30-helm.el ends here
