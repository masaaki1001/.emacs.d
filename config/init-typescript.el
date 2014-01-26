;;;; typescript
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))

(require 'tss)
(setq tss-popup-help-key "C-c C-c t")
(setq tss-jump-to-definition-key "C-c C-c C-t")

(tss-config-default)
(setq typescript-auto-indent-flag nil)

(define-key typescript-mode-map (kbd "C-c C-j") nil)

(provide 'init-typescript)
