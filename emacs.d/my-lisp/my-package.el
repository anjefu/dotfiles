(if (not (version< emacs-version "24"))
    (progn
      (require 'package)
      (add-to-list 'package-archives
                   '("marmalade" .
                     "http://marmalade-repo.org/packages/"))
      (package-initialize)

      (when (not package-archive-contents)
        (package-refresh-contents))

      (defvar my-packages '(cmake-mode
                            csharp-mode
                            erc-hl-nicks
                            haskell-mode
                            magit
                            markdown-mode
                            scala-mode
                            slime
                            sml-mode)
        "A list of packages to ensure are installed at launch.")

      (dolist (p my-packages)
        (when (not (package-installed-p p))
          (package-install p)))))

(provide 'my-package)
