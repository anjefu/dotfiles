; if we are not running in a terminal, then set color theme
(unless (equal window-system nil)
    (progn
      (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;      (load-theme 'tango-dark t)
      (load-theme 'tomorrow-night t)
;      (load-theme 'tomorrow t)
;      (load-theme 'zenburn t)
      ))

(provide 'my-theme)
