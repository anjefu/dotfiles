(defun my-text-mode-hook ()
  (function (lambda ()
	      (text-mode-hook-identify)
	      (turn-on-auto-fill))))
(add-hook 'text-mode-hook 'my-text-mode-hook)
(setq default-major-mode 'text-mode)

(provide 'my-text-mode)
