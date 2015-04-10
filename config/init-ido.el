(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t
      ido-use-faces nil)

(ido-vertical-mode)
(flx-ido-mode t)
(setq smex-save-file (expand-file-name ".smex-items" resource-dir))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(provide 'init-ido)
