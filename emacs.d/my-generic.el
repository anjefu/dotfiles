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

; Whitespace
(setq-default show-trailing-whitespace t)

; Cursor
(setq-default cursor-type 'box)
(blink-cursor-mode 0)

; Alerts
(setq visible-bell nil)

; Fonts
(set-face-attribute 'default nil :height 100)

; Disabled commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(provide 'my-generic)
