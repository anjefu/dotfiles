(if (not (version< emacs-version "24"))
    (progn
      (require 'package)
      (add-to-list 'package-archives
                   '("marmalade" .
                     "http://marmalade-repo.org/packages/"))
      (package-initialize)))

(provide 'my-package)
