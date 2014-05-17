;;;; typescript
(when (require 'typescript nil t)
  (add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
  (setq typescript-auto-indent-flag nil)
  (define-key typescript-mode-map (kbd "C-c C-j") nil)

  (eval-after-load "typescript"
    (setq require-final-newline t)
    )

  (when (require 'tss nil t)
    (setq tss-popup-help-key "C-c C-c t")
    (setq tss-jump-to-definition-key "C-c C-c C-t")

    (tss-config-default)
    (remove-hook 'after-save-hook 'tss-run-flymake)
    )
  )

(provide 'init-typescript)
