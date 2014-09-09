;;;; edit utils
;; expand-region.el
;; http://d.hatena.ne.jp/syohex/20120117/1326814127
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; multiple-cursors.el
(require 'multiple-cursors)
(setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; smartparens.el
(require 'smartparens-config)
(smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)

;; move-text.el
(move-text-default-bindings)

(require 'edit-server)
(setq edit-server-new-frame nil)
(edit-server-start)

(provide 'init-edit-util)
