;;;; MacOS
 (when is-mac
  (require 'ucs-normalize) ;; Mac用
  ;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil)
  )

(provide 'init-mac)
