(use-package mozc-popup
  :if (eq system-type 'gnu/linux)
  :init
  (progn
    (setq default-input-method "japanese-mozc")
    (setq mozc-candidate-style 'popup))
  :ensure t)
