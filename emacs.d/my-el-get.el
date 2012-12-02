(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(if (require 'el-get nil 'noerror)
    (el-get 'sync))

(setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

(provide 'my-el-get)
