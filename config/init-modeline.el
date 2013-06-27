;; diminish.el
(when (require 'diminish nil t)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  (diminish 'elisp-slime-nav-mode)
  )

(provide 'init-modeline)
