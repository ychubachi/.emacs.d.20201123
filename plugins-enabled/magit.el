
(dolist (package '(magit))
  (when (not (package-installed-p package))
    (package-install package)))

(require 'magit)
