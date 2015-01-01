;; diminish
(with-eval-after-load "auto-complete" (diminish 'auto-complete-mode))
(with-eval-after-load "yasnippet" (diminish 'yas-minor-mode))
(with-eval-after-load "undo-tree" (diminish 'undo-tree-mode))
(with-eval-after-load "volatile-highlights" (diminish 'volatile-highlights-mode))
(with-eval-after-load "view" (diminish 'view-mode))
(with-eval-after-load "elisp-slime-nav" (diminish 'elisp-slime-nav-mode))
(with-eval-after-load "eldoc" (diminish 'eldoc-mode))
(with-eval-after-load "anzu"(diminish 'anzu-mode))
(with-eval-after-load "smartparens" (diminish 'smartparens-mode))
(with-eval-after-load "magit" (diminish 'magit-auto-revert-mode))
(with-eval-after-load "highlight-symbol" (diminish 'highlight-symbol-mode))

(provide 'init-modeline)
