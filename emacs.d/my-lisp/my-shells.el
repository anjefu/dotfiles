(defun shell-dir (name dir)
  (interactive "sShell name: \nDDirectory: ")
  (let ((default-directory dir))
    (shell name)))

(defun make-shells ()
  (interactive)
  (shell-dir "x" "~/projects/")
  (shell-dir "y" "~/projects/")
  (shell-dir "z" "~/projects/"))

(global-set-key "\C-cs" 'shell)

(shell-dir "*shell*" "~/projects/")

(provide 'my-shells)
