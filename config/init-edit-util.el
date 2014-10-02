;; expand-region
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; multiple-cursors
(setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

(with-eval-after-load "mutilple-cursors"
  (define-key mc/mark-more-like-this-extended-keymap (kbd "C-s") 'phi-search)
  (define-key mc/mark-more-like-this-extended-keymap (kbd "C-r") 'phi-search-backward))

;; smartparens
(smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)

;; move-text
(move-text-default-bindings)

(provide 'init-edit-util)
