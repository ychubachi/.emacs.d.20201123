;;; exec-path-from-shell

;; ** ShellのPATH設定を引き継ぐ
;;   - [[http://qiita.com/catatsuy/items/3dda714f4c60c435bb25][EmacsでPATHの設定が引き継がれない問題をエレガントに解決する - Qiita {キータ}]]

(use-package exec-path-from-shell
  :init
  (progn (exec-path-from-shell-initialize))
  :ensure t)
