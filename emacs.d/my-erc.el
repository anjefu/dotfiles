(let ((ercpass-file "~/.ercpass"))
  (if (file-exists-p ercpass-file)
      (progn
        (require 'erc)
        (load ercpass-file)
        (require 'erc-services)

        (erc-services-mode 1)

        (and
         (require 'erc-highlight-nicknames)
         (add-to-list 'erc-modules 'highlight-nicknames)
         (erc-update-modules))

        (setq erc-prompt-for-nickserv-password nil)

        (setq erc-nickserv-passwords
              `((freenode (("amesign" . ,freenode-amesign-pass)))))

        (global-set-key "\C-cef" (lambda () (interactive)
                                   (erc :server "irc.freenode.net" :port "6667"
                                        :nick "amesign" :full-name "amesign")))
        (setq erc-autojoin-channels-alist '(("freenode.net"
                                             "#emacs")))

        (setq erc-interpret-mirc-color t)
        (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT")))))

(provide 'my-erc)
