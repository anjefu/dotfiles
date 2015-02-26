; Load path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

; Exec path
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/local/sbin")

; Environment
(setenv "PAGER" "/bin/cat")

; Mac OS X
(setq mac-command-modifier 'meta)

; Character encoding
(setq default-buffer-file-coding-system 'utf-8)

; General preferences
(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq use-dialog-box nil)
(setq transient-mark-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Scrolling
(setq scroll-step 1)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed 't)
(setq mouse-wheel-follow-mouse 't)

; Mode line
(line-number-mode t)
(column-number-mode t)
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

; X Windows clipboard support
(setq x-select-enable-clipboard t)

; Indentation
(setq-default indent-tabs-mode nil)
(setq c-default-style '((java-mode . "java")
                        (awk-mode . "awk")
                        (other . "k&r")))
(setq-default c-basic-offset 4)
(setq-default tab-width 4)

; Whitespace
(setq-default show-trailing-whitespace t)

; Cursor
(setq-default cursor-type 'bar)
(blink-cursor-mode t)
(setq blink-cursor-blinks 0)

; Alerts
(setq visible-bell nil)

; Screen splitting
; from https://www.reddit.com/r/emacs/comments/25v0eo/you_emacs_tips_and_tricks/chldury
(defun vsplit-last-buffer ()
  (interactive)
  (split-window-vertically)
  (other-window 1 nil)
  (switch-to-next-buffer))

(defun hsplit-last-buffer ()
  (interactive)
   (split-window-horizontally)
  (other-window 1 nil)
  (switch-to-next-buffer))

; Fonts
(set-face-attribute 'default nil :height 100)

(global-set-key (kbd "C-x 2") 'vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'hsplit-last-buffer)

; Disabled commands
(put 'narrow-to-region 'disabled nil)

(provide 'my-generic)
