;;;; flycheck
(add-hook 'ruby-mode-hook 'flycheck-mode)
(add-hook 'css-mode-hook 'flycheck-mode)
(setq flycheck-check-syntax-automatically '(save idle-change mode-enabled)
      flycheck-idle-change-delay 10)

(eval-after-load "flycheck"
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  )

(eval-after-load "flycheck-color-mode-line"
  '(custom-set-faces
    '(flycheck-color-mode-line-error-face ((t (:background "red3" :foreground "#efefef" :weight normal))))
    '(flycheck-color-mode-line-info-face ((t (:inherit (flycheck-fringe-info default) :background "DodgerBlue3" :foreground "#efefef" :weight normal))))
    '(flycheck-color-mode-line-warning-face ((t (:background "yellow3" :foreground "black" :weight normal))))
    )
  )

(provide 'init-flycheck)
