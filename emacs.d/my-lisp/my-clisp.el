; (defvar common-lisp-hyperspec-root "~/.emacs.d/lisp/HyperSpec-7-0/HyperSpec/")
; (defvar common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt"))

(if (eq system-type 'darwin)
    (setq inferior-lisp-program "/usr/local/bin/sbcl")
    (setq inferior-lisp-program "/usr/bin/sbcl"))

(require 'slime)
(setq slime-net-coding-system 'utf-8-unix)
(slime-setup)

(provide 'my-clisp)
