;; quickrun.el
;; https://github.com/syohex/emacs-quickrun
(when (require 'quickrun nil t)
  (global-set-key [(f5)] 'quickrun))

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

;; change-inner.el
;; https://github.com/magnars/change-inner.el
(when (require 'change-inner nil t)
  (global-set-key (kbd "M-i") 'change-inner)
  (global-set-key (kbd "M-o") 'change-outer)
  )

;; Experimental multiple-cursors
(when (require 'multiple-cursors nil t)
  (setq mc/list-file "~/.emacs.d/resource/.mc-lists.el")
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

;; pomodoro.el
;; https://github.com/baudtack/pomodoro.el
(when (require 'pomodoro nil t)
  (pomodoro-add-to-mode-line)
  )

;; smartparens.el
(require 'smartparens-config)

;; move-text.el
(when (require 'move-text nil t)
  (move-text-default-bindings)
  )

;; highlight-escape-sequences.el
(when (require 'highlight-escape-sequences nil t)
  (hes-mode))

;; smartparens.el
(require 'smartparens-config)

;; move-text.el
(when (require 'move-text nil t)
  (move-text-default-bindings)
  )

;; highlight-escape-sequences.el
(when (require 'highlight-escape-sequences nil t)
  (hes-mode))

(provide 'init-util)
