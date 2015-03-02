; if we are not running in a terminal, then set color theme
(unless (equal window-system nil)
  (progn
    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
    (load-theme 'tomorrow-night t)))

(provide 'my-theme)
