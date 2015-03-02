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
                                             "#emacs"
                                             "#haskell"
                                             "#haskell-hacphi"
                                             "#opensim"
                                             "#opensim-dev")))

        (setq erc-interpret-mirc-color t)
        (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT")))))

(provide 'my-erc)
