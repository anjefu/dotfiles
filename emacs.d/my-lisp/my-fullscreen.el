; fullscreen support from http://github.com/typester/emacs

; only set if we are not running in a terminal
(unless (equal 't (framep (car (frame-list))))
  (if (fboundp 'ns-toggle-fullscreen)
      (global-set-key (kbd "M-RET") 'ns-toggle-fullscreen)
    (global-set-key (kbd "M-RET") 'toggle-fullscreen)))

(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
    (set-frame-parameter nil 'fullscreen
                         (if (equal 'fullboth current-value)
                             (if (boundp 'old-fullscreen) old-fullscreen nil)
                           (progn (setq old-fullscreen current-value)
                                  'fullboth)))))

; Make new frames fullscreen by default. Note: this hook doesn't do
; anything to the initial frame if it's in your .emacs, since that
; file is read _after_ the initial frame is created.
(add-hook 'after-make-frame-functions 'toggle-fullscreen)

(if (fboundp 'ns-toggle-fullscreen)
    (ns-toggle-fullscreen)
  (toggle-fullscreen))

(provide 'my-fullscreen)
