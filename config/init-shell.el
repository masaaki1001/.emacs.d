;;;; shell
;; multi-term
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/bash"))

;; emacs-bash-completion
(when (require 'bash-completion nil t)
  (bash-completion-setup))

;; emamux
(when (require 'emamux nil t)
  (global-set-key (kbd "C-c C-c t") 'emamux:send-command)
  (custom-set-variables
   '(emamux:completing-read-type 'helm)))

(provide 'init-shell)
