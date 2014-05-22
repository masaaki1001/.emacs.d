(ido-mode t)
(ido-everywhere t)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point nil
      ido-use-faces nil
      ido-max-prospects 10)

(when (require 'ido-ubiquitous nil t)
  (ido-ubiquitous-mode t))

(when (require 'ido-vertical-mode nil t)
  (ido-vertical-mode))

(when (require 'flx-ido nil t)
  (flx-ido-mode t))

(when (require 'smex nil t)
  (global-set-key [remap execute-extended-command] 'smex)
  (setq smex-save-file (expand-file-name ".smex-items" user-emacs-directory))
  )


(provide 'init-ido)
