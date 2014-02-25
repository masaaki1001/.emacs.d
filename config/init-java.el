;;;; java
(when (require 'eclim nil t)
  (setq eclim-executable "~/ide/eclipse/eclim")
  (global-eclim-mode)

  (require 'eclimd)
  (setq eclimd-executable "~/ide/eclipse/eclimd")
  (custom-set-variables
   '(eclim-eclipse-dirs '("~/ide/eclipse")))

  (require 'ac-emacs-eclim-source)
  (add-hook 'java-mode-hook 'ac-emacs-eclim-java-setup)
  )

(provide 'init-java)
