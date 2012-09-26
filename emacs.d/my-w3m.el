(add-to-list 'load-path "~/.emacs.d/lisp/w3m")

(require 'w3m-load)
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)

(setq w3m-use-cookies t)
(setq w3m-cookie-accept-domains '("google.com"))
(setq w3m-display-inline-images nil)
(setq w3m-default-display-inline-images t)
(setq w3m-home-page "http://www.google.com/intl/en/")

(defun google (term)
  (interactive "sSearch term: ")
  (w3m-goto-url (concat "http://google.com/search?q=" term)))

(provide 'my-w3m)
