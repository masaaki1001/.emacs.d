;;----------------------------------------------------------------------------
;; Mac用設定
;;----------------------------------------------------------------------------
(require 'ucs-normalize) ;; Mac用

(defun mac-os-p ()
  (member window-system '(mac ns)))
(defun linuxp ()
  (eq window-system 'x))

(when (mac-os-p)
  ;; Command-Key and Option-Key
  (setq ns-command-modifier 'meta)
  (setq ns-alternate-modifier 'super)
  (setq mac-pass-command-to-system nil)
  ;; フォント設定
  ;; http://weboo-returns.com/blog/inconsolata-as-a-programming-font/?utm_source=twitterfeed&utm_medium=twitter
  ;;(set-face-attribute 'default nil
  ;;                    :family "inconsolata"
  ;;                    :height 140)
  )

(provide 'init-mac)
