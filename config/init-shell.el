;;;; shell
;; multi-term
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/bash"))

;; emacs-bash-completion
(when (require 'bash-completion nil t)
  (bash-completion-setup))

(provide 'init-shell)
