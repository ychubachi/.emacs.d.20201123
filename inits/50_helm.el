;;; helm の設定

;;    - [[http://d.hatena.ne.jp/a_bicky/20140104/1388822688][Helm をストレスなく使うための個人的な設定 - あらびき日記]]
;;    - [[https://github.com/emacs-helm/helm/wiki][Home · emacs-helm/helm Wiki]]
;;    - [[http://sleepboy-zzz.blogspot.jp/2012/09/anythinghelm.html][memo: AnythingからHelmに移行しました]]
;;    - [[http://www49.atwiki.jp/ntemacs/m/pages/32.html][NTEmacs @ ウィキ - helm を使うための設定 - @ｳｨｷﾓﾊﾞｲﾙ]]
;;    - [[http://qiita.com/akisute3@github/items/7c8ea3970e4cbb7baa97][Emacs - helm-mode 有効時でも helm-find-files は無効にする - Qiita {キータ}]]
;;    - [[http://www.fan.gr.jp/~ring/doc/elisp_19/elisp-jp_14.html#IDX592][GNU Emacs Lispリファレンス・マニュアル: 12. マクロ]]
;; 	 - 逆引用符は`,'の引数を評価し、 リスト構造にその値を入れます。
;;    - helm-mode 1 はおせっかいすぎるので使わない

;; - helm-M-xを有効にする
;; - helm-miniを有効にする

(use-package migemo)

(use-package helm-config
  :bind (("M-x" . helm-M-x)
	 ("C-c h" . helm-mini)
	 ("C-x C-r" . helm-recentf))
  :init
  (progn

    ;; - helm-descbinds-mode を評価すると、describe-bindings 関数が helm-descbinds 関数で上書きされる
    ;; - describe-bindings にはもともと C-h b がバインドされているので結果として C-h b で helm-descbinds が起動されるようになる
    ;; - TODO bind-keys を使ったほうが確認しやすいかもしれない

    ;; |                |                   | 上書き |
    ;; |----------------+-------------------+--------|
    ;; | helm-descbinds | describe-bindings | C-h b  |
    (use-package helm-descbinds
      :init
      (helm-descbinds-mode)
      :ensure t)

    ;; - M-x helm-package で起動
    ;; - [[http://rubikitch.com/2014/11/16/helm-package/][emacs helm-package.el : パッケージをhelmインターフェースで即座に見付けてインストール | MELPA Emacs Lisp Elisp パッケージ インストール 設定 使い方 スクリーンショット | るびきち「日刊Emacs」]]

    (use-package helm-package :ensure t))

  :config
  (progn
    ;; migemoを有効にする
    (helm-migemo-mode 1))
  :ensure helm)
