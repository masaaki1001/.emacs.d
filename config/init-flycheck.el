;;;; flycheck
(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'css-mode-hook 'flycheck-mode)
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 10)

(provide 'init-flycheck)
