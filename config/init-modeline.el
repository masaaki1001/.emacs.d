;; diminish.el
(when (require 'diminish nil t)
  (diminish 'auto-complete-mode)
  (diminish 'yas-minor-mode)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  (diminish 'elisp-slime-nav-mode)
  )

(provide 'init-modeline)
