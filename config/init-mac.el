;;----------------------------------------------------------------------------
;; Mac用設定
;;----------------------------------------------------------------------------
(defun mac-os-p ()
  (member window-system '(mac ns)))
(defun linuxp ()
  (eq window-system 'x))

(when (mac-os-p)
  (require 'ucs-normalize) ;; Mac用
  ;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil)
  )

(provide 'init-mac)
