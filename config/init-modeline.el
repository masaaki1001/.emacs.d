(when (require 'anzu nil t)
(global-anzu-mode t)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :weight 'bold))

;; diminish.el
(when (require 'diminish nil t)
  (diminish 'auto-complete-mode)
  (diminish 'yas-minor-mode)
  (diminish 'undo-tree-mode)
  (diminish 'volatile-highlights-mode)
  (diminish 'view-mode)
  (diminish 'elisp-slime-nav-mode)
  (diminish 'anzu-mode)
  )

(when (require 'anzu nil t)
(global-anzu-mode t)
(set-face-attribute 'anzu-mode-line nil
                    :foreground "black" :weight 'bold))

(provide 'init-modeline)
