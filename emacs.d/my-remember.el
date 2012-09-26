(add-to-list 'load-path "~/.emacs.d/lisp/remember-2.0")
(require 'remember-autoloads)
(setq org-directory "~/projects/org/")
(setq org-default-notes-file (concat org-directory "inbox.org"))
(setq org-remember-templates
      '((?t "* %?\n  %i\n  %a" "~/projects/org/inbox.org" "Inbox")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'org-remember)

(provide 'my-remember)
