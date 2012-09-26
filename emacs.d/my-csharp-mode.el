(defun my-csharp-mode-hook ()
  (progn
    (turn-on-font-lock)
    (setq tab-width 4)
    (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(provide 'my-csharp-mode)
