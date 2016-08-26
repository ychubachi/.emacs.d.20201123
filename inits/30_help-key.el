;;;; C-h を DELにします

;; - C-h が押されたら，C-? (<DEL>) に変換する．
;; - ヘルプは[F1]でも参照できる．
;; - 参考
;; 	 - [[http://akisute3.hatenablog.com/entry/20120318/1332059326][EmacsのC-hをbackspaceとして使用する - 勉強日記]]
;; 	 - [[http://www.gnu.org/software/emacs/manual/html_node/efaq/Swapping-keys.html#Swapping-keys][Swapping keys - GNU Emacs FAQ]]
;; - keyboad-translate関数はサーバにする際動作しなかった
;; 	 - [[http://lists.gnu.org/archive/html/help-gnu-emacs/2009-10/msg00505.html][Re: keyboard-translate not working with emacs daemon]]

(define-key key-translation-map [?\C-h] [?\C-?])

;;;; C-c ? を help-for-help にします
(bind-key "C-c ?" 'help-for-help)
