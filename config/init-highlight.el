;;;; highlight
;; volatile-highlights.el
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t)
  )

;; highlight-symbol.el
(when (require 'highlight-symbol nil t)

  (dolist (hook '(prog-mode-hook html-mode-hook typescript-mode-hook))
    (add-hook hook 'highlight-symbol-mode)
    (add-hook hook 'highlight-symbol-nav-mode))

  (defun highlight-symbol-all (&optional nlines)
    "Call `all' with the symbol at point.
 Each line is displayed with NLINES lines before and after, or -NLINES
 before if NLINES is negative."
    (interactive "P")
    (interactive "P")  (if (thing-at-point 'symbol)
                           (all (highlighht-symbol-get-symbol) nlines)
                         (error "No symbol at point")))
  )

(provide 'init-highlight)
