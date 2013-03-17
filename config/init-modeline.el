;; https://github.com/TeMPOraL/nyan-mode
(when (require 'nyan-mode nil t))

;; diminish.el
(when (require 'diminish nil t)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  (diminish 'elisp-slime-nav-mode)
  )

(when (require 'mainline nil t))

(provide 'init-modeline)
