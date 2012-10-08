(setq-default c-basic-offset 4
              tab-width 4)

(defun my-c-mode-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'statement-cont 4)
  (c-set-offset 'topmost-intro-cont 0)
  (c-set-offset 'block-open 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'arglist-cont-nonempty 4)
;  (c-set-offset 'cpp-macro 'csharp-lineup-region)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'case-label 4)
  (c-toggle-auto-newline 1)
  (define-key c-mode-map [(ctrl tab)] 'complete-tag))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

(defun my-csharp-mode-hook ()
  (turn-on-font-lock)
  (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete))
(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)

(autoload 'csharp-mode "csharp-mode-0.7.0" "Major mode for editing C# code." t)
(autoload 'ledger-mode "ledger" "Ledger mode." t)

(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(add-to-list 'auto-mode-alist '("\\.command$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.i$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(provide 'my-modes)
