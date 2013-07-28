;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; samrtrep.el
;;
;; [連続操作を素敵にするsmartrep.el作った - sheephead](http://sheephead.homelinux.org/2011/12/19/6930/)
;;

;; パッケージのインストール
(setq package-list '(smartrep))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

(require 'smartrep)

(eval-after-load "org"
  '(progn
     (smartrep-define-key 
	 org-mode-map "C-c" '(("C-n" . (lambda () 
					 (outline-next-visible-heading 1)))
			      ("C-p" . (lambda ()
					 (outline-previous-visible-heading 1)))))))
