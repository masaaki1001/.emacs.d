;; https://github.com/TeMPOraL/nyan-mode
(require 'nyan-mode nil t)

;; diminish.el
(when (require 'diminish nil t)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  (diminish 'elisp-slime-nav-mode)
  )

;; (when (require 'main-line nil t)
;;    (setq main-line-separator-style 'roundstub))

(provide 'init-modeline)
