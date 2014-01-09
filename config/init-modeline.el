;;;; diminish.el
(when (require 'diminish nil t)
  (eval-after-load "auto-complete" '(diminish 'auto-complete-mode))
  (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
  (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
  (eval-after-load "volatile-highlights" '(diminish 'volatile-highlights-mode))
  (eval-after-load "view" '(diminish 'view-mode))
  (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
  (eval-after-load "anzu"'(diminish 'anzu-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  )

(provide 'init-modeline)
