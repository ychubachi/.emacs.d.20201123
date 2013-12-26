;;; helm-package.el ---

;; Copyright (C) 2012 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA <syohex@gmail.com>
;; URL:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:

(eval-when-compile
  (require 'cl))

(require 'helm)
(require 'package)

(defun helm-c-package-installed-packages (pred)
  (let ((copyed (copy-sequence package-archive-contents)))
    (loop with sorted = (sort copyed (lambda (a b)
                                       (string< (car a) (car b))))
          for candidate in sorted
          for package = (symbol-name (car candidate))
          for name = (if (> (length package) 30)
                         (concat (substring package 0 27) "...")
                       package)
          for desc = (truncate-string-to-width
                      (aref (cdr candidate) 2) (- (frame-width) 31))
          when (funcall pred (car candidate))
          collect (cons (format "%-30s| %s" name desc) package))))

(defvar helm-c-package-available-source
  '((name . "helm available packages")
    (init . (lambda ()
              (unless package--initialized
                (package-initialize t))))
    (candidates . (lambda ()
                    (helm-c-package-installed-packages
                     (lambda (e) (not (assoc e package-alist))))))
    (candidate-number-limit . 9999)
    (volatile)))

(defvar helm-c-package-installed-source
  '((name . "helm installed packages")
    (init . (lambda ()
              (unless package--initialized
                (package-initialize t))))
    (candidates . (lambda ()
                    (helm-c-package-installed-packages
                     (lambda (e) (assoc e package-alist)))))
    (candidate-number-limit . 9999)
    (volatile)))

(defun helm-package ()
  (interactive)
  (let ((buf (get-buffer-create "*helm-package*")))
    (helm :sources '(helm-c-package-available-source helm-c-package-installed-source)
          :buffer buf)))

(provide 'helm-package)

;;; helm-package.el ends here
