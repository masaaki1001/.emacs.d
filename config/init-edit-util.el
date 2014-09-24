;;;; edit utils
;; expand-region.el
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; multiple-cursors.el
(setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; smartparens.el
(smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)

;; move-text.el
(move-text-default-bindings)

(provide 'init-edit-util)
