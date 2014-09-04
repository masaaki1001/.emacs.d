;;;; shell
;; emacs-bash-completion
(require 'bash-completion)
(bash-completion-setup)

;; emamux
(require 'emamux)
(global-set-key (kbd "C-c C-c t") 'emamux:send-command)
(custom-set-variables
 '(emamux:completing-read-type 'helm))

(provide 'init-shell)
