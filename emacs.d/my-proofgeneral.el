(let ((proofgeneral-1 "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el")
      (proofgeneral-2 "/usr/local/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el"))
  (if (file-exists-p proofgeneral-1)
      (load-file proofgeneral-1)
    (if (file-exists-p proofgeneral-2)
        (load-file proofgeneral-2))))

(provide 'my-proofgeneral)
