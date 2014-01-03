;;;; diminish.el
(when (require 'diminish nil t)
  (eval-after-load "auto-complete-mode" '(diminish 'auto-complete-mode))
  (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
  (eval-after-load "undo-tree-mode" '(diminish 'undo-tree-mode))
  (eval-after-load "volatile-highlights-mode" '(diminish 'volatile-highlights-mode))
  (eval-after-load "view-mode" '(diminish 'view-mode))
  (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
  (eval-after-load "anzu-mode" '(diminish 'anzu-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  )

(provide 'init-modeline)
