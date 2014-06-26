;;;; edit utils
;; expand-region.el
;; http://d.hatena.ne.jp/syohex/20120117/1326814127
(when (require 'expand-region nil t)
  (global-set-key (kbd "C-,") 'er/expand-region)
  (global-set-key (kbd "C-M-,") 'er/contract-region)
  )

;; multiple-cursors.el
(when (require 'multiple-cursors nil t)
  (require 'mc-interactive-insert-numbers)
  (setq mc/list-file (expand-file-name ".mc-lists.el" user-emacs-directory))
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;; smartparens.el
(unless (fboundp 'cl-flet)
  (defalias 'cl-flet 'flet))
(when (require 'smartparens-config nil t)
  (smartparens-global-mode t)
  (setq sp-autoescape-string-quote nil)
  )

;; move-text.el
(when (require 'move-text nil t)
  (move-text-default-bindings)
  )

;; https://github.com/stsquad/emacs_chrome
(when (require 'edit-server nil t)
  (setq edit-server-new-frame nil)
  (edit-server-start)
  )

(provide 'init-edit-util)
