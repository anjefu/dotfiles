(require 'org)
(require 'org-timetracker)

(setq org-hide-leading-stars t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(defun inbox ()
  (interactive)
  (find-file "~/projects/org/inbox.org"))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-todo-keywords '("TODO" "STARTED" "WAITING" "DONE"))
(setq org-agenda-files (file-expand-wildcards "~/projects/org/*.org"))
; (setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-directory "~/projects/org")

(provide 'my-org)
