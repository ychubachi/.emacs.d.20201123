
(add-hook 'outline-minor-mode-hook
          (lambda () (local-set-key "\C-c\C-o"
                                    outline-mode-prefix-map)))))
