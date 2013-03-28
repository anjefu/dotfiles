(defun latex-word-count ()
  (interactive)
  (shell-command (concat "/usr/bin/texcount "
                         ; "options go here "
                         (buffer-file-name))))

(define-key latex-mode-map "\C-cw" 'latex-word-count)

(provide 'my-latex)
