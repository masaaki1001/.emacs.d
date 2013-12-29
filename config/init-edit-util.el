;; expand-region.el
;; https://github.com/magnars/expand-region.el
;; http://d.hatena.ne.jp/syohex/20120117/1326814127
(when (require 'expand-region nil t)
  (global-set-key (kbd "C-,") 'er/expand-region)
  ;; http://d.hatena.ne.jp/yuheiomori0718/20120118/1326893579
  (global-set-key (kbd "C-M-,") 'er/contract-region);広がりすぎたら戻る処理
  ;; transient-mark-modeが nilでは動作ないので注意
  (transient-mark-mode t)
  (when (require 'js2-refactor nil t)
    (define-key js2-mode-map (kbd "C-c C-r") 'js2-rename-var))
  (when (require 'inline-string-rectangle nil t)
    (global-set-key (kbd "C-x r t") 'inline-string-rectangle))
  )

;; multiple-cursors.el
(when (require 'multiple-cursors nil t)
  (setq mc/list-file "~/.emacs.d/resource/.mc-lists.el")
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;; smartparens.el
(unless (fboundp 'cl-flet)
  (defalias 'cl-flet 'flet))
(when (require 'smartparens-config)
  (smartparens-global-mode t)
  (setq sp-autoescape-string-quote nil)
  )

;; move-text.el
(when (require 'move-text nil t)
  (move-text-default-bindings)
  )

(provide 'init-edit-util)
