;; Emacs
(setq inhibit-splash-screen t)		; no splash screen, thanks
(setq inhibit-startup-screen t)

(tool-bar-mode 0)
(scroll-bar-mode 0)
;; (tool-bar-mode -1)			; no tool bar with icons
;; (scroll-bar-mode -1)			; no scroll bars
(menu-bar-mode 0)
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))

(global-hl-line-mode)			; highlight current line

;; avoid compiz manager rendering bugs
(add-to-list 'default-frame-alist '(alpha . 80))
