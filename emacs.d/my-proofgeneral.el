(let ((proofgeneral "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el"))
  (if (file-exists-p proofgeneral)
      (load-file proofgeneral)))

(provide 'my-proofgeneral)
