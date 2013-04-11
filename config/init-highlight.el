;; volatile-highlights.el
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

(when (require 'highlight-symbol nil t)
  (defun highlight-symbol-all (&optional nlines)
    "Call `all' with the symbol at point.
 Each line is displayed with NLINES lines before and after, or -NLINES
 before if NLINES is negative."
    (interactive "P")
    (interactive "P")  (if (thing-at-point 'symbol)
                           (all (highlighht-symbol-get-symbol) nlines)
                         (error "No symbol at point")))
  )

;; auto-highlight-symbol-mode.el
;; https://github.com/mhayashi1120/auto-highlight-symbol-mode
;; http://d.hatena.ne.jp/yuheiomori0718/20111222/1324562208
;; http://d.hatena.ne.jp/syohex/20110126/1296048465
(when (require 'auto-highlight-symbol nil t)
  (global-auto-highlight-symbol-mode t)
  (ahs-set-idle-interval 5) ;ハイライトまでの待機時間 デフォルトは1秒
  )

;; fic-mode.el
;; https://github.com/lewang/fic-mode
;; highlight word is TODO or FIXME
(require 'fic-mode nil t)

(provide 'init-highlight)
