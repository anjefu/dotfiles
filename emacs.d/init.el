; Load path
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

; Exec path
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/local/sbin")
(add-to-list 'exec-path (expand-file-name "~/.cabal/bin"))

;; package config

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
; (if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(set-frame-parameter (selected-frame) 'alpha 95)

; Set PATH
(setenv "PATH" (concat
                (expand-file-name "~/.opam/system/bin:")
                (expand-file-name "~/.cabal/bin:")
                "/usr/local/bin:"
                "/usr/local/sbin:"
                "/usr/local/cuda/bin:"
                "/usr/local/mysql/bin:"
                "/usr/local/texlive/2014/bin/x86_64-darwin:"
                (getenv "PATH")))

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
(set-face-attribute 'default nil :height 140)
(set-frame-font "Inconsolata" nil t)

(global-set-key (kbd "C-x 2") 'vsplit-last-buffer)
(global-set-key (kbd "C-x 3") 'hsplit-last-buffer)

; Disabled commands
(put 'narrow-to-region 'disabled nil)

;; bbdb config

; (add-to-list 'load-path "~/.emacs.d/lisp/bbdb")
; (require 'bbdb)
; (bbdb-initialize)

;; clisp config

; (defvar common-lisp-hyperspec-root "~/.emacs.d/lisp/HyperSpec-7-0/HyperSpec/")
; (defvar common-lisp-hyperspec-symbol-table (concat common-lisp-hyperspec-root "Data/Map_Sym.txt"))

(if (eq system-type 'darwin)
    (setq inferior-lisp-program "/usr/local/bin/sbcl")
    (setq inferior-lisp-program "/usr/bin/sbcl"))

; (require 'slime)
; (setq slime-net-coding-system 'utf-8-unix)
; (slime-setup)

;; compile config

(global-set-key "\C-cc" 'compile)

;; erc config

(let ((ercpass-file "~/.ercpass"))
  (if (file-exists-p ercpass-file)
      (progn
        (require 'erc)
        (load ercpass-file)
        (require 'erc-services)

        (erc-services-mode 1)

        (setq erc-prompt-for-nickserv-password nil)

        (setq erc-nickserv-passwords
              `((freenode (("amesign" . ,freenode-amesign-pass)
                           ("anjefu" . ,freenode-anjefu-pass)))))

        (global-set-key "\C-cef" (lambda () (interactive)
                                   (erc :server "irc.freenode.net" :port "6667"
                                        :nick "anjefu" :full-name "anjefu")))
         (setq erc-autojoin-channels-alist '(("freenode.net"
;                                              "#emacs"
                                              "#haskell"
;                                              "#haskell-hacphi"
;                                              "#opensim"
;                                              "#opensim-dev"
                                              "#oplss"
                                              )))

        (setq erc-interpret-mirc-color t)
        (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT")))))

;; fullscreen config

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

;; ido config

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)

;; ispell config

(setq-default ispell-program-name "aspell")

;; latex config

; (load "auctex.el" nil t t)
; (load "preview-latex.el" nil t t)

; (defun latex-word-count ()
;   (interactive)
;   (shell-command (concat "/usr/bin/texcount "
;                          ; "options go here "
;                          (buffer-file-name))))

; (define-key latex-mode-map "\C-cw" 'latex-word-count)

;; modes config

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
;  (define-key csharp-mode-map "\t" 'c-tab-indent-or-complete)
  )

(add-hook 'csharp-mode-hook 'my-csharp-mode-hook)

(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)

(autoload 'cmake-mode "cmake-mode.el" t)
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)

(load-file (let ((coding-system-for-read 'utf-8))
              (shell-command-to-string "agda-mode locate")))

(add-to-list 'auto-mode-alist '("CMakeLists\\.txt\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cl$" . lisp-mode))
(add-to-list 'auto-mode-alist '("\\.cmake\\'" . cmake-mode))
(add-to-list 'auto-mode-alist '("\\.cu$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(add-to-list 'auto-mode-alist '("\\.command$" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.i$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.i$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(if (file-exists-p (expand-file-name "~/third-party/llvm/utils/emacs/llvm-mode.el"))
    (progn
      (add-to-list 'load-path (expand-file-name "~/third-party/llvm/utils/emacs"))
      (require 'llvm-mode)))

;; haskell-mode
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-process-type 'cabal-repl)

;; objc-mode config

(setq auto-mode-alist
      (cons '("\\.mm$" . objc-mode) auto-mode-alist))

(defun bh-choose-header-mode ()
  (interactive)
  (if (string-equal (substring (buffer-file-name) -2) ".h")
      (progn
        ;; OK, we got a .h file, if a .m file exists we'll assume it's
        ; an objective c file. Otherwise, we'll look for a .cpp file.
        (let ((dot-m-file (concat (substring (buffer-file-name) 0 -1) "m"))
              (dot-cpp-file (concat (substring (buffer-file-name) 0 -1) "cpp")))
          (if (file-exists-p dot-m-file)
              (progn
                (objc-mode))
            (if (file-exists-p dot-cpp-file)
                (c++-mode)))))))

(add-hook 'find-file-hook 'bh-choose-header-mode)

(defun bh-compile ()
  (interactive)
  (let ((df (directory-files "."))
        (has-proj-file nil))
    (while (and df (not has-proj-file))
      (let ((fn (car df)))
        (if (> (length fn) 10)
            (if (string-equal (substring fn -10) ".xcodeproj")
                (setq has-proj-file t))))
      (setq df (cdr df)))
    (if has-proj-file
        (compile "xcodebuild -configuration Debug")
      (compile "make"))))

;; org config

(require 'org)

(setq org-hide-leading-stars t)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(defun inbox ()
  (interactive)
  (find-file "~/projects/org/todo.org"))
(define-key global-map "\C-ca" 'org-agenda)
(setq org-todo-keywords '("TODO(t)" "STARTED(s)" "WAITING(w)" "DONE(d)"))
(setq org-agenda-files '("~/projects/org/todo.org"))
; (setq org-agenda-include-diary t)
(setq org-agenda-include-all-todo t)
(setq org-agenda-start-on-weekday nil)
(setq org-directory "~/projects/org")

(require 'remember)
; (org-remember-insinuate)
(setq org-directory "~/projects/org/")
(setq org-default-notes-file (concat org-directory "todo.org"))
(setq org-remember-templates
      '((?t "* %?\n  %i\n  %a" "~/projects/org/todo.org" "Inbox")))
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)
(define-key global-map "\C-cr" 'remember)

;; proofgeneral config

(let ((proofgeneral-1 "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el")
      (proofgeneral-2 "/usr/local/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el"))
  (if (file-exists-p proofgeneral-1)
      (load-file proofgeneral-1)
    (if (file-exists-p proofgeneral-2)
        (load-file proofgeneral-2))))

(setq proof-splash-enable nil)

;; scala config

(require 'scala-mode-auto)

;; shells config

(defun shell-dir (name dir)
  (interactive "sShell name: \nDDirectory: ")
  (let ((default-directory dir))
    (shell name)))

(global-set-key "\C-cs" 'shell)

(shell-dir "*shell*" "~/projects/")

;; text-mode config

(defun my-text-mode-hook ()
  (function (lambda ()
              (text-mode-hook-identify)
              (turn-on-auto-fill))))
(add-hook 'text-mode-hook 'my-text-mode-hook)
(setq default-major-mode 'text-mode)

;; theme config

; if we are not running in a terminal, then set color theme
(unless (equal window-system nil)
  (progn
;    (setq frame-background-mode 'light)
    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
    (load-theme 'tomorrow-night t)))
;    (load-theme 'solarized t)))

;; tramp config

(require 'tramp)
(setq tramp-default-method "ssh")

;; uniquify config

(require 'uniquify)
; customize uniquify-buffer-name-style
(setq uniquify-buffer-name-style 'forward)

;; w3m config

(add-to-list 'load-path "~/.emacs.d/lisp/w3m")

(require 'w3m-load)
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)

(setq w3m-use-cookies t)
(setq w3m-cookie-accept-domains nil)
(setq w3m-display-inline-images nil)
(setq w3m-default-display-inline-images t)
(setq w3m-home-page "http://www.duckduckgo.com/")

(defun websearch (term)
  (interactive "sSearch term: ")
  (w3m-goto-url (concat "http://duckduckgo.com/?q=" term)))

;; windows config

(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;; server config

(server-start)
