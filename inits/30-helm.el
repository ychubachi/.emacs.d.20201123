;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; * https://github.com/emacs-helm/helm/wiki
;; * http://www49.atwiki.jp/ntemacs/m/pages/32.html
;;

;; パッケージのインストール
(setq package-list '(helm helm-descbinds migemo helm-migemo imenu-anywhere helm-themes))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; 初期設定
(require 'helm-config)
(helm-mode 1)

; helm-miniを起動するキーを設定する
(global-set-key (kbd "C-c h") 'helm-mini)

; helmを使わないコマンドを設定する
; - http://qiita.com/akisute3@github/items/7c8ea3970e4cbb7baa97
(add-to-list 'helm-completing-read-handlers-alist '(kill-buffer . nil))

;; 候補を作って描写するまでのタイムラグ設定する（デフォルトは 0.1）
(setq helm-idle-delay 0.2)

;; 文字列を入力してから検索するまでのタイムラグを設定する（デフォルトは 0.1）
(setq helm-input-idle-delay 0.2)

;; ミニバッファで C-k 入力時にカーソル以降を削除する
(setq helm-delete-minibuffer-contents-from-point t)

;; TAB で補完する（C-zと同じにする）
; (define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)

;; C-h でバックスペースと同じように文字を削除できるようにする
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)

;; C-o は ime変換用として使っているので、helm-next-source を C-l に変更する
(define-key helm-map (kbd "C-o") nil)
(define-key helm-map (kbd "C-l") 'helm-next-source)

;; describe-bindings(C-h b)のhelm版
(require 'helm-descbinds)
(helm-descbinds-mode)

;; helm-migemo
(require 'helm-migemo)

;; imenu-anywhere
(global-set-key (kbd "C-/") 'helm-imenu-anywhere)

;; helm-themes
(require 'helm-themes)
