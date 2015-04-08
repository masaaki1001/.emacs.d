;; expand-region
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; multiple-cursors
(require 'mc-interactive-insert-numbers)
(setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(define-key mc/keymap (kbd "C-'") 'mc-hide-unmatched-lines-mode)

;; smartparens
(require 'smartparens-config)
(smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)

;; move-text
(move-text-default-bindings)

;; fcopy
(global-set-key (kbd "C-c f") 'fcopy)

;; edit-server
(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(provide 'init-edit-util)
