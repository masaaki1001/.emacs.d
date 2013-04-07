;;----------------------------------------------------------------------------
;; auto-complete
;; http://cx4a.org/software/auto-complete/manual.ja.html
;;----------------------------------------------------------------------------
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/repositories/auto-complete/dict")
  (setq ac-comphist-file "~/.emacs.d/resource/ac-comphist.dat")
  (ac-config-default)
  (setq ac-delay 0.5)
  ;; (setq ac-auto-show-menu 0.8)
  (setq ac-use-menu-map t)
  (add-hook 'auto-complete-mode-hook
            (lambda ()
              (define-key ac-completing-map (kbd "C-n") 'ac-next)
              (define-key ac-completing-map (kbd "C-p") 'ac-previous)
              (define-key ac-completing-map (kbd "C-s") 'ac-isearch)
              ))

  )

(provide 'init-auto-complete)
