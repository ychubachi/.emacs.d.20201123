;; ;; under mac, have Command as Meta and keep Option for localized input
;; (when (string-match "apple-darwin" system-configuration)
;;   (setq mac-allow-anti-aliasing t)
;;   (setq mac-command-modifier 'meta)
;;   (setq mac-option-modifier 'none))

;; (unless (string-match "apple-darwin" system-configuration)
;;   ;; on mac, there's always a menu bar drown, don't have it empty
;;   (menu-bar-mode -1))

;; ;; choose your own fonts, in a system dependant way
;; (if (string-match "apple-darwin" system-configuration)
;;     (set-face-font 'default "Monaco-13")
;;   (set-face-font 'default "Monospace-10"))
