;;;; anything.el
(when (require 'anything-config nil t)
  (setq anything-samewindow nil)
  (setq anything-candidate-number-limit 300)

  (define-key anything-map (kbd "C-p")   'anything-previous-line)
  (define-key anything-map (kbd "C-n")   'anything-next-line)
  )

(provide 'init-anything)
