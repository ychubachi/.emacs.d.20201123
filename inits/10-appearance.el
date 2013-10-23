;;; 10-appearance.el --- <description>
;;; Commentary:
;; - no splash screen, thanks
;;; Code:

(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

(tool-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode 0)

(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

;;; 10-appearance.el ends here
